// create-stock.dto.ts

import {
  IsString,
  IsNumber,
  IsOptional,
  IsArray,
  ValidateNested,
} from "class-validator";
import { Type } from "class-transformer";

export class CreateStockFeatureDto {
  @IsNumber()
  featureId: number;

  @IsString()
  value: string;
}

export class CreateStockDto {
  @IsString()
  name: string;

  @IsString()
  excerpt: string;

  @IsString()
  description: string;

  @IsString()
  contract: string;

  @IsNumber()
  categoryId: number;

  @IsString()
  sapNumber: string;

  @IsNumber()
  valueAvailable: number;

  @IsNumber()
  valueOnContract: number;

  @IsOptional()
  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => CreateStockFeatureDto)
  features?: CreateStockFeatureDto[];
}
