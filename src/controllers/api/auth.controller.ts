import {
  Controller,
  Post,
  Body,
  Req,
  HttpStatus,
  HttpException,
  UsePipes,
  ValidationPipe,
} from "@nestjs/common";
import { Request } from "express";
import { ApiResponse } from "src/misc/api.response.class";
import { UserService } from "src/services/user/user.service";
import * as crypto from "crypto";
import * as jwt from "jsonwebtoken";
import { jwtSecret } from "config/jwt.secret";
import { JwtRefreshDataDto } from "src/dtos/auth/jwt.refresh.dto";
import { UserRefreshTokenDto } from "src/dtos/auth/user.refresh.token.dto";
import { LoginInfoDto } from "src/dtos/auth/login.info.dto";
import { JWTDataDto } from "src/dtos/auth/jwt.data.dto";
import { LoginUserDto } from "src/dtos/user/login.user.dto";

@Controller("auth")
export class AuthController {
  constructor(private readonly userService: UserService) {}

  @Post("login")
  async doLogin(
    @Body() data: LoginUserDto,
    @Req() req: Request
  ): Promise<LoginInfoDto | ApiResponse> {
    const user = await this.userService.getByEmail(data.email);
    if (!user) {
      return new Promise<ApiResponse>((resolve) =>
        resolve(new ApiResponse("error", -3001, "Neispravan email"))
      );
    }

    const passwordHash = crypto.createHash("sha512");
    passwordHash.update(data.password);
    const passwordHashString = passwordHash.digest("hex").toUpperCase();

    if (user.passwordHash !== passwordHashString) {
      return new Promise<ApiResponse>((resolve) =>
        resolve(new ApiResponse("error", -3002, "Neispravna lozinka"))
      );
    }

    const jwtData = new JWTDataDto();
    jwtData.phoneIp = user.phoneIp;
    jwtData.role = user.role.role;
    jwtData.id = user.userId;
    jwtData.identity = user.email;
    jwtData.exp = this.getDatePlus(60 * 1);
    jwtData.ip = req.ip.toString();
    jwtData.ua = req.headers["user-agent"];

    const token: string = jwt.sign(jwtData.toPlainObject(), jwtSecret);
    const jwtRefreshData = new JwtRefreshDataDto();
    jwtRefreshData.phoneIp = jwtData.phoneIp;
    jwtRefreshData.role = jwtData.role;
    jwtRefreshData.id = jwtData.id;
    jwtRefreshData.identity = jwtData.identity;
    jwtRefreshData.exp = this.getDatePlus(60 * 60 * 24 * 31);
    jwtRefreshData.ip = jwtData.ip;
    jwtRefreshData.ua = jwtData.ua;
    const refreshToken: string = jwt.sign(
      jwtRefreshData.toPlainObject(),
      jwtSecret
    );

    const responseObject = new LoginInfoDto(
      user.userId,
      user.role.role,
      user.email,
      token,
      user.phoneIp,
      refreshToken,
      this.getIsoDate(jwtRefreshData.exp)
    );

    await this.userService.addToken(
      user.userId,
      refreshToken,
      this.getDatabaseDateFormat(this.getIsoDate(jwtRefreshData.exp))
    );

    return new Promise((resolve) => resolve(responseObject));
  }

  @Post("refresh")
  @UsePipes(new ValidationPipe({ whitelist: false, transform: true }))
  async userTokenRefresh(
    @Req() req: Request,
    @Body() data: UserRefreshTokenDto
  ): Promise<LoginInfoDto | ApiResponse> {
    const userToken = await this.userService.getUserToken(data.token);

    if (!userToken) {
      return new ApiResponse("error", -10002, "No such refresh token!");
    }

    if (userToken.isValid === 0) {
      return new ApiResponse("error", -10003, "The token is no longer valid!");
    }

    const sada = new Date().toISOString();
    const datumIsteka = new Date(userToken.expireAt).toISOString();

    if (datumIsteka < sada) {
      return new ApiResponse("error", -10004, "The token has expired!");
    }

    let jwtRefreshData: JwtRefreshDataDto;

    try {
      jwtRefreshData = jwt.verify(data.token, jwtSecret);
    } catch (e) {
      throw new HttpException("Bad token found", HttpStatus.UNAUTHORIZED);
    }

    if (!jwtRefreshData) {
      throw new HttpException("Bad token found", HttpStatus.UNAUTHORIZED);
    }

    if (jwtRefreshData.ip !== req.ip.toString()) {
      throw new HttpException("Bad token found", HttpStatus.UNAUTHORIZED);
    }

    if (jwtRefreshData.ua !== req.headers["user-agent"]) {
      throw new HttpException("Bad token found", HttpStatus.UNAUTHORIZED);
    }

    const jwtData = new JWTDataDto();
    jwtData.phoneIp = jwtRefreshData.phoneIp;
    jwtData.role = jwtRefreshData.role;
    jwtData.id = jwtRefreshData.id;
    jwtData.identity = jwtRefreshData.identity;
    jwtData.exp = this.getDatePlus(60 * 5);
    jwtData.ip = jwtRefreshData.ip;
    jwtData.ua = jwtRefreshData.ua;

    const token: string = jwt.sign(jwtData.toPlainObject(), jwtSecret);

    const responseObject = new LoginInfoDto(
      jwtData.id,
      jwtData.role,
      jwtData.identity,
      token,
      jwtData.phoneIp,
      data.token,
      this.getIsoDate(jwtRefreshData.exp)
    );

    return responseObject;
  }

  private getDatePlus(numberOfSeconds: number): number {
    return new Date().getTime() / 1000 + numberOfSeconds;
  }

  private getIsoDate(timestamp: number): string {
    const date = new Date();
    date.setTime(timestamp * 1000);
    return date.toISOString();
  }

  private getDatabaseDateFormat(isoFormat: string): string {
    return isoFormat.substr(0, 19).replace("T", " ");
  }
}
