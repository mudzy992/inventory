import {
  HttpException,
  HttpStatus,
  Injectable,
  NestMiddleware,
} from "@nestjs/common";
import { NextFunction, Request, Response } from "express";
import * as jwt from "jsonwebtoken";
import { jwtSecret } from "config/jwt.secret";
import { UserService } from "src/services/user/user.service";
import { JWTDataDto } from "src/dtos/auth/jwt.data.dto";

@Injectable() // Ni pod razno ovo zaboraviti
export class AuthMiddleware implements NestMiddleware {
  constructor(
    public userService: UserService
  ) {}
  async use(req: Request, res: Response, next: NextFunction) {
    if (req.path === "/api/webhook/github") {
      return next();
    } else {
      if (!req.headers.authorization) {
        throw new HttpException("Nema tokena", HttpStatus.UNAUTHORIZED);
      }
      const token = req.headers.authorization;
      const tokenParts = token.split(" ");
      if (tokenParts.length !== 2) {
        throw new HttpException("Ne valja token", HttpStatus.UNAUTHORIZED);
      }
      const tokenString = tokenParts[1];

      let jwtData: JWTDataDto;

      try {
        jwtData = jwt.verify(tokenString, jwtSecret);
      } catch (e) {
        throw new HttpException("Bad token found", HttpStatus.UNAUTHORIZED);
      }

      if (!jwtData) {
        throw new HttpException("Bad token found", HttpStatus.UNAUTHORIZED);
      }

      if (jwtData.ip !== req.ip.toString()) {
        throw new HttpException("Bad token found", HttpStatus.UNAUTHORIZED);
      }

      if (jwtData.ua !== req.headers["user-agent"]) {
        throw new HttpException("Bad token found", HttpStatus.UNAUTHORIZED);
      }

      const user = await this.userService.getById(jwtData.id);
      if (!user) {
        throw new HttpException("Account not found", HttpStatus.UNAUTHORIZED);
      }

      const trenutniTimestamp = new Date().getTime() / 1000;
      if (trenutniTimestamp >= jwtData.exp) {
        throw new HttpException(
          "The token has expired",
          HttpStatus.UNAUTHORIZED
        );
      }

      req.token = jwtData;

      next();
      // Nakon što smo sve provjere završili, potrebo je AuthMiddleware implementirati u app.module.ts
    }
  }
}
