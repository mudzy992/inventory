import { IsOptional, IsString, IsInt, IsEnum } from 'class-validator';

export class EditArticleDto {
  @IsString()
  @IsOptional()
  serialNumber?: string;

  @IsString()
  @IsOptional()
  invNumber?: string;

  @IsInt()
  @IsOptional()
  userId?: number;

  @IsInt()
  @IsOptional()
  documentId?: number;

  @IsEnum(['zaduženo', 'razduženo', 'otpisano'], { each: true })
  @IsOptional()
  status?: 'zaduženo' | 'razduženo' | 'otpisano';

  @IsOptional()
  features?: Array<{ featureId: number; value: string }>;
}
