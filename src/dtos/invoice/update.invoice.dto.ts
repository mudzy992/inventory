// update-invoice.dto.ts
import { IsEnum, IsNotEmpty, IsOptional, IsString } from 'class-validator';

export class UpdateInvoiceDto {
  @IsString()
  @IsNotEmpty()
  issueDate: string;

  @IsString()
  @IsNotEmpty()
  customer: string;

  @IsEnum(["izvršenje", "plaćeno"])
  @IsOptional()
  status: "izvršenje" | "plaćeno" | null;
}
