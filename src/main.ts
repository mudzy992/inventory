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
  const PORT = process.env.PORT || 3005
  await app.listen(PORT, ()=> console.log("Sluša ba portu " + PORT));
}
bootstrap();
