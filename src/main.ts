import { NestFactory } from '@nestjs/core';
import { NestExpressApplication } from '@nestjs/platform-express';
import { StorageConfig } from 'config/storage.config';
import { AppModule } from './app.module';

async function bootstrap() {
  const app = await NestFactory.create<NestExpressApplication>(AppModule);
  app.useStaticAssets(StorageConfig.prenosnica.destination, {
    prefix: StorageConfig.prenosnica.urlPrefix,
    maxAge: StorageConfig.prenosnica.maxAge,
    index: false,
  });
  app.enableCors();
  /* await app.listen(3005); */
}
bootstrap();
