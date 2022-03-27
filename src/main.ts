import { NestFactory } from '@nestjs/core';
import { NestExpressApplication } from '@nestjs/platform-express';
import { StorageConfig } from 'config/storage.config';
import { AppModule } from './app.module';

async function bootstrap() {
  const app = await NestFactory.create<NestExpressApplication>(AppModule);
  app.useStaticAssets(StorageConfig.prenosnicaPrefix.destination, {
    prefix: StorageConfig.prenosnicaPrefix.urlPrefix,
    maxAge: StorageConfig.prenosnicaPrefix.maxAge,
    index: false,
  });
  app.enableCors();
  await app.listen(3005);
}
bootstrap();
