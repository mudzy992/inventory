import { IsNotEmpty, IsOptional, IsInt, Min } from 'class-validator';

export class EditCategoryDto {
  @IsOptional()
  @IsNotEmpty()
  name: string;

  @IsOptional()
  imagePath: string;

  @IsOptional()
  @IsInt()
  @Min(1)
  parentCategoryId: number;
}
