import { IsInt, IsString, IsNotEmpty, IsOptional } from 'class-validator';

export class CreateOrUpdateArticleFeatureDto {
  @IsInt()
  @IsNotEmpty()
  articleId: number;

  @IsInt()
  @IsNotEmpty()
  featureId: number;

  @IsString()
  @IsNotEmpty()
  featureValue: string;
}
