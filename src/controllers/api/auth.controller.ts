import {
  Controller,
  Post,
  Body,
  Req,
  HttpStatus,
  HttpException,
} from '@nestjs/common';
import { Request } from 'express';
import { ApiResponse } from 'src/misc/api.response.class';
import { AdministratorService } from 'src/services/administrator/administrator.service';
import { LoginAdministratorDto } from 'src/services/administrator/login.administrator.dto';
import { UserService } from 'src/services/user/user.service';
import * as crypto from 'crypto';
import * as jwt from 'jsonwebtoken';
import { jwtSecret } from 'config/jwt.secret';
import { JwtRefreshDataDto } from 'src/dtos/auth/jwt.refresh.dto';
import { AdministratorRefreshTokenDto } from 'src/dtos/auth/administrator.refresh.token.dto';
import { AddNewEmployeDto } from 'src/dtos/user/add.new.employe.dto';
import { LoginUserDto } from 'src/dtos/user/login.user.dto';
import { UserRefreshTokenDto } from 'src/dtos/auth/user.refresh.token.dto';
import { LoginInfoDto } from 'src/dtos/auth/login.info.dto';
import { JWTDataDto } from 'src/dtos/auth/jwt.data.dto';

@Controller('auth')
export class AuthController {
  constructor(
    public administratorService: AdministratorService,
    public userService: UserService,
  ) {}
  @Post('administrator/login')
  async doAdministratorLogin(
    @Body() data: LoginAdministratorDto,
    @Req() req: Request,
  ): Promise<LoginInfoDto | ApiResponse> {
    const administrator = await this.administratorService.getByUsername(
      data.username,
    );
    if (!administrator) {
      return new Promise<ApiResponse>((resolve) =>
        resolve(new ApiResponse('error', -3001, 'neispravno korisničko ime')),
      );
    }
    const passwordHash = crypto.createHash('sha512');
    passwordHash.update(data.password);
    const passwordHashString = passwordHash.digest('hex').toUpperCase();

    if (administrator.passwordHash !== passwordHashString) {
      return new Promise<ApiResponse>((resolve) =>
        resolve(new ApiResponse('error', -3002, 'neispravna lozinka')),
      );
    }
    const jwtData = new JWTDataDto();
    jwtData.role = 'administrator';
    jwtData.id = administrator.administratorId;
    jwtData.identity = administrator.username;
    jwtData.exp = this.getDatePlus(60 * 5);
    jwtData.ip = req.ip.toString();
    jwtData.ua = req.headers['user-agent'];

    const token: string = jwt.sign(jwtData.toPlainObject(), jwtSecret);
    const jwtRefreshData = new JwtRefreshDataDto();
    jwtRefreshData.role = jwtData.role;
    jwtRefreshData.id = jwtData.id;
    jwtRefreshData.identity = jwtData.identity;
    jwtRefreshData.exp = this.getDatePlus(60 * 60 * 24 * 31);
    jwtRefreshData.ip = jwtData.ip;
    jwtRefreshData.ua = jwtData.ua;
    const refreshToken: string = jwt.sign(
      jwtRefreshData.toPlainObject(),
      jwtSecret,
    );

    const responseObject = new LoginInfoDto(
      administrator.administratorId,
      administrator.username,
      token,
      refreshToken,
      this.getIsoDate(jwtRefreshData.exp),
    );
    return new Promise((resolve) => resolve(responseObject));
  }

  @Post('administrator/refresh')
  async administratorTokenRefresh(
    @Req() req: Request,
    @Body() data: AdministratorRefreshTokenDto,
  ): Promise<LoginInfoDto | ApiResponse> {
    const administratorToken =
      await this.administratorService.getAdministratorToken(data.token);

    if (!administratorToken) {
      return new ApiResponse('error', -10002, 'Neispravan osvježavajući token');
    }

    if (administratorToken.isValid === 0) {
      return new ApiResponse('error', -10003, 'Token više nije validan');
    }

    const sada = new Date();
    const datumIsteka = new Date(administratorToken.expireAt);
    if (datumIsteka.getTime() < sada.getTime()) {
      return new ApiResponse('error', -10004, 'Token je istekao');
    }

    let jwtRefreshData: JwtRefreshDataDto;
    try {
      jwtRefreshData = jwt.verify(data.token, jwtSecret);
    } catch (e) {
      throw new HttpException('Neispravan token', HttpStatus.UNAUTHORIZED);
    }
    if (!jwtRefreshData) {
      throw new HttpException('Neispravan token', HttpStatus.UNAUTHORIZED);
    }
    if (jwtRefreshData.ip !== req.ip.toString()) {
      throw new HttpException('Neispravan token', HttpStatus.UNAUTHORIZED);
    }
    if (jwtRefreshData.ua !== req.headers['user-agent']) {
      throw new HttpException('Neispravan token', HttpStatus.UNAUTHORIZED);
    }

    const jwtData = new JWTDataDto();
    jwtData.role = jwtRefreshData.role;
    jwtData.id = jwtRefreshData.id;
    jwtData.identity = jwtRefreshData.identity;
    jwtData.exp = this.getDatePlus(60 * 5);
    jwtData.ip = jwtRefreshData.ip;
    jwtData.ua = jwtRefreshData.ua;

    const token: string = jwt.sign(jwtData.toPlainObject(), jwtSecret);

    const responseObject = new LoginInfoDto(
      jwtData.id,
      jwtData.identity,
      token,
      data.token,
      this.getIsoDate(jwtRefreshData.exp),
    );

    return responseObject;
  }

  @Post('user/register')
  async userRegister(@Body() data: AddNewEmployeDto) {
    return await this.userService.createNewUser(data);
  }

  @Post('user/login')
  async doUserLogin(
    @Body() data: LoginUserDto,
    @Req() req: Request,
  ): Promise<LoginInfoDto | ApiResponse> {
    const user = await this.userService.getByEmail(data.email);
    if (!user) {
      return new Promise<ApiResponse>((resolve) =>
        resolve(new ApiResponse('error', -3001, 'ne valja username')),
      );
    }

    const passwordHash = crypto.createHash('sha512');
    passwordHash.update(data.password);
    const passwordHashString = passwordHash.digest('hex').toUpperCase();

    if (user.passwordHash !== passwordHashString) {
      return new Promise<ApiResponse>((resolve) =>
        resolve(new ApiResponse('error', -3002, 'ne valja password')),
      );
    }
    const jwtData = new JWTDataDto();
    jwtData.role = 'user';
    jwtData.id = user.userId;
    jwtData.identity = user.email;
    jwtData.exp = this.getDatePlus(60 * 1);
    jwtData.ip = req.ip.toString();
    jwtData.ua = req.headers['user-agent'];

    const token: string = jwt.sign(jwtData.toPlainObject(), jwtSecret);

    const jwtRefreshData = new JwtRefreshDataDto();
    jwtRefreshData.role = jwtData.role;
    jwtRefreshData.id = jwtData.id;
    jwtRefreshData.identity = jwtData.identity;
    jwtRefreshData.exp = this.getDatePlus(60 * 60 * 24 * 31);
    jwtRefreshData.ip = jwtData.ip;
    jwtRefreshData.ua = jwtData.ua;

    const refreshToken: string = jwt.sign(
      jwtRefreshData.toPlainObject(),
      jwtSecret,
    );

    const responseObject = new LoginInfoDto(
      user.userId,
      user.email,
      token,
      refreshToken,
      this.getIsoDate(jwtRefreshData.exp),
    );

    await this.userService.addToken(
      user.userId,
      refreshToken,
      this.getDatabaseDateFormat(this.getIsoDate(jwtRefreshData.exp)),
    );

    return new Promise((resolve) => resolve(responseObject));
  }

  @Post('user/refresh') // http://localhost:3000/auth/user/refresh/
  async userTokenRefresh(
    @Req() req: Request,
    @Body() data: UserRefreshTokenDto,
  ): Promise<LoginInfoDto | ApiResponse> {
    const userToken = await this.userService.getUserToken(data.token);

    if (!userToken) {
      return new ApiResponse('error', -10002, 'No such refresh token!');
    }

    if (userToken.isValid === 0) {
      return new ApiResponse('error', -10003, 'The token is no longer valid!');
    }

    const sada = new Date().toISOString();
    const datumIsteka = new Date(userToken.expireAt).toISOString();

    if (datumIsteka < sada) {
      return new ApiResponse('error', -10004, 'The token has expired!');
    }

    let jwtRefreshData: JwtRefreshDataDto;

    try {
      jwtRefreshData = jwt.verify(data.token, jwtSecret);
    } catch (e) {
      throw new HttpException('Bad token found', HttpStatus.UNAUTHORIZED);
    }

    if (!jwtRefreshData) {
      throw new HttpException('Bad token found', HttpStatus.UNAUTHORIZED);
    }

    if (jwtRefreshData.ip !== req.ip.toString()) {
      throw new HttpException('Bad token found', HttpStatus.UNAUTHORIZED);
    }

    if (jwtRefreshData.ua !== req.headers['user-agent']) {
      throw new HttpException('Bad token found', HttpStatus.UNAUTHORIZED);
    }

    const jwtData = new JWTDataDto();
    jwtData.role = jwtRefreshData.role;
    jwtData.id = jwtRefreshData.id;
    jwtData.identity = jwtRefreshData.identity;
    jwtData.exp = this.getDatePlus(60 * 5);
    jwtData.ip = jwtRefreshData.ip;
    jwtData.ua = jwtRefreshData.ua;

    const token: string = jwt.sign(jwtData.toPlainObject(), jwtSecret);

    const responseObject = new LoginInfoDto(
      jwtData.id,
      jwtData.identity,
      token,
      data.token,
      this.getIsoDate(jwtRefreshData.exp),
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
    return isoFormat.substr(0, 19).replace('T', ' ');
  }
} /* Kraj koda */
