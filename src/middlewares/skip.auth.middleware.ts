import { Injectable, NestMiddleware } from '@nestjs/common';
import { Request, Response, NextFunction } from 'express';

@Injectable()
export class SkipAuthMiddleware implements NestMiddleware {
  use(req: Request, res: Response, next: NextFunction) {
    // Ovaj middleware će se primjenjivati samo na /api/webhook
    // i neće provjeravati JWT autorizaciju
    return next();
  }
}
