import { NestFactory } from "@nestjs/core";
import { NestExpressApplication } from "@nestjs/platform-express";
import { StorageConfig } from "config/storage.config";
import { AppModule } from "./app.module";
import * as cors from 'cors';
import { HttpException, HttpStatus, ValidationPipe } from "@nestjs/common";

async function bootstrap() {
  const app = await NestFactory.create<NestExpressApplication>(AppModule);
  const allowedOrigins = [
    'http://localhost:4001',
    'http://192.168.4.180:4001', // Promjenjivo u odnosu na lokalhost (upisuje se adresa uređaja na kojem je pokrenut frontend)
    'http://inventory.hopto.org',
  ];

  const corsOptions = {
    origin: function (origin, callback) {
      if (allowedOrigins.indexOf(origin) !== -1 || !origin) {
        callback(null, true);
      } else {
        console.warn(`CORS blokira zahtjev: ${origin}`);
        callback(null, false); 
      }
    },
    methods: ['GET', 'POST', 'PUT', 'DELETE', 'PATCH'],
    allowedHeaders: ['Content-Type', 'Authorization'],
  };
  app.use(cors(corsOptions));
  app.useGlobalPipes(
    new ValidationPipe({
      whitelist: false,
      forbidNonWhitelisted: true,
      transform: true,
      skipMissingProperties: true,
      exceptionFactory: (errors) =>
        new HttpException(
          { message: "Greška prilikom validacije podataka!", errors },
          HttpStatus.BAD_REQUEST,
        ),
    }),
  );  
  app.useStaticAssets(StorageConfig.prenosnica.destination, {
    prefix: StorageConfig.prenosnica.urlPrefix,
    maxAge: StorageConfig.prenosnica.maxAge,
    index: false,
  });
  const PORT = process.env.PORT || 3006;
  await app.listen(PORT, () => console.log("Aplikacija radi na portu: " + PORT));
}
bootstrap();
