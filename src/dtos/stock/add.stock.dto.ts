import * as Validator from "class-validator";

export class AddStockDto {
  @Validator.IsNotEmpty()
  @Validator.IsString()
  @Validator.Length(2, 255)
  name: string;

  @Validator.IsString()
  @Validator.Length(2, 255)
  excerpt: string | null;

  @Validator.IsString()
  @Validator.Length(2, 255)
  description: string | null;

  @Validator.IsString()
  @Validator.Length(2, 255)
  contract: string | null;

  @Validator.IsNumber()
  categoryId: number;

  @Validator.IsString()
  @Validator.Length(2, 255)
  sapNumber: string;

  @Validator.IsNumber()
  valueOnContract: number;

  @Validator.IsNumber()
  valueAvailable: number;
}
