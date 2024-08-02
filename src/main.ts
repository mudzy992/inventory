import { NestFactory } from "@nestjs/core";
import { NestExpressApplication } from "@nestjs/platform-express";
import { StorageConfig } from "config/storage.config";
import { AppModule } from "./app.module";
import * as cors from 'cors';
import { ValidationPipe } from "@nestjs/common";

async function bootstrap() {
  const app = await NestFactory.create<NestExpressApplication>(AppModule);
  const allowedOrigins = [
    'http://localhost',
    'http://inventory.hopto.org',
  ];

  const corsOptions = {
    origin: function (origin, callback) {
      if (allowedOrigins.indexOf(origin) !== -1 || !origin) {
        callback(null, true);
      } else {
        callback(new Error('Not allowed by CORS'));
      }
    },
    methods: ['GET', 'POST', 'PUT', 'DELETE', 'PATCH'],
    allowedHeaders: ['Content-Type', 'Authorization'],
  };
  app.use(cors(corsOptions));
  app.useGlobalPipes(new ValidationPipe());
  app.useStaticAssets(StorageConfig.prenosnica.destination, {
    prefix: StorageConfig.prenosnica.urlPrefix,
    maxAge: StorageConfig.prenosnica.maxAge,
    index: false,
  });
  app.enableCors();
  const PORT = process.env.PORT || 3006;
  await app.listen(PORT, () => console.log("Aplikacija radi na portu: " + PORT));
}
bootstrap();
