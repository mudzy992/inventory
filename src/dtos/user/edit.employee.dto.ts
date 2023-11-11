import * as Validator from 'class-validator';

export class EditEmployeeDto {
  @Validator.IsNotEmpty()
  @Validator.IsString()
  @Validator.Length(2, 64)
  surename: string;

  @Validator.IsNotEmpty()
  @Validator.IsString()
  @Validator.Length(2, 64)
  forname: string;

  @Validator.IsNotEmpty()
  @Validator.IsEmail({
    allow_ip_domain: false,
    allow_utf8_local_part: true,
    require_tld: true,
  })
  email: string;

  @Validator.IsString()
  @Validator.Length(2, 64)
  localNumber: string;

  @Validator.IsString()
  @Validator.Length(2, 64)
  telephone: string;

  @Validator.IsNumber()
  departmentId: number;

  @Validator.IsNumber()
  jobId: number;

  @Validator.IsNumber()
  locationId: number;

  @Validator.IsNotEmpty()
  @Validator.IsString()
  @Validator.Length(6, 12)
  password: string;

  @Validator.IsString()
  @Validator.Length(2, 64)
  status: "aktivan" | "neaktivan";
}
