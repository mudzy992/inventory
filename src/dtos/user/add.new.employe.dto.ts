import * as Validator from "class-validator";

export class AddNewEmployeDto {
  @Validator.IsNotEmpty()
  @Validator.IsString()
  @Validator.Length(2, 255)
  surname: string;

  @Validator.IsNotEmpty()
  @Validator.IsString()
  @Validator.Length(2, 255)
  forname: string;

  @Validator.IsEmail({
    allow_ip_domain: false,
    allow_utf8_local_part: true,
    require_tld: true,
  })
  email: string;

  @Validator.IsString()
  @Validator.IsOptional()
  localNumber: string;

  @Validator.IsString()
  @Validator.IsOptional()
  telephone: string | null;

  @Validator.IsNumber()
  departmentId: number;

  @Validator.IsNumber()
  jobId: number;

  @Validator.IsNumber()
  organizationId: number;

  @Validator.IsNumber()
  locationId: number;

  @Validator.IsNotEmpty()
  @Validator.IsString()
  @Validator.Length(8, 20)
  password: string;

  @Validator.IsIn(["aktivan", "neaktivan"])
  @Validator.IsOptional()
  status: "aktivan" | "neaktivan";

  @Validator.IsNumber()
  @Validator.IsOptional()
  code: number;

  @Validator.IsIn(["muško", "žensko"])
  gender: "muško" | "žensko";

  @Validator.IsString()
  @Validator.IsOptional()
  phoneIp: string | null;
}
