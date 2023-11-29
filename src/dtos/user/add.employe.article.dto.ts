import { IsInt, IsNotEmpty, IsNumber, IsString } from 'class-validator';

export class AddEmployeArticleDto {
  @IsInt()
  articleId: number;

  @IsInt()
  documentId: number;

  @IsNumber()
  @IsNotEmpty()
  value: number | null;

  @IsString()
  @IsNotEmpty()
  comment: string | null;

  @IsString()
  @IsNotEmpty()
  serialNumber: string;

  @IsString()
  @IsNotEmpty()
  invBroj: string;
}
