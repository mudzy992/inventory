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
    try{
      if (!req.headers.authorization) {
        throw new HttpException("Tokena apsolutno nema. Potrebno generisati novi.", HttpStatus.UNAUTHORIZED);
      }

      const token = req.headers.authorization;
      const tokenParts = token.split(" ");
      if (tokenParts.length !== 2) {
        throw new HttpException("Token nije ispravan.", HttpStatus.UNAUTHORIZED);
      }
      const tokenString = tokenParts[1];

      let jwtData: JWTDataDto;

      try {
        jwtData = jwt.verify(tokenString, jwtSecret);
      } catch (e) {
        throw new HttpException("Token nije ispravan, razlog nepoznat.", HttpStatus.UNAUTHORIZED);
      }

      if (!jwtData || jwtData.ip !== req.ip || jwtData.ua !== req.headers["user-agent"]) {
        throw new HttpException("Token neispravan. IP, Internet Pregledač ili neki drugi uslov. ", HttpStatus.UNAUTHORIZED);
      }

      const user = await this.userService.getById(jwtData.id);
      if (!user) {
        throw new HttpException("Korisnički račun nije pronađen. Molimo za provjeru podataka.", HttpStatus.UNAUTHORIZED);
      }

      const trenutniTimestamp = new Date().getTime() / 1000;
      if (trenutniTimestamp >= jwtData.exp) {
        throw new HttpException(
          "Token je istekao",
          HttpStatus.UNAUTHORIZED
        );
      }
      req.token = jwtData;
      next();
    } catch(error){
      res.status(
        error.status || HttpStatus.INTERNAL_SERVER_ERROR
      ).json({ error: error.message || "Greška na serveru." });
    }
  }
}
