import * as Validator from "class-validator";

export class EditEmployeeDto {
  @Validator.IsNotEmpty()
  @Validator.IsString()
  @Validator.Length(2, 64)
  surname?: string;

  @Validator.IsNotEmpty()
  @Validator.IsString()
  @Validator.Length(2, 64)
  forname?: string;

  @Validator.IsNotEmpty()
  @Validator.IsEmail({
    allow_ip_domain: false,
    allow_utf8_local_part: true,
    require_tld: true,
  })
  email?: string;

  @Validator.IsString()
  @Validator.Length(2, 64)
  localNumber?: string;

  @Validator.IsString()
  @Validator.Length(2, 64)
  telephone?: string;

  @Validator.IsNumber()
  departmentId?: number;

  @Validator.IsNumber()
  jobId?: number;

  @Validator.IsNumber()
  locationId?: number;

  @Validator.IsNumber()
  organizationId?: number;

  @Validator.ValidateIf((object) => object.password !== undefined)
  @Validator.IsNotEmpty({ message: 'Lozinka ne smije biti prazna.' })
  @Validator.IsString({ message: 'Lozinka mora biti string.' })
  @Validator.MinLength(8, { message: 'Lozinka mora imati najmanje 8 karaktera.' })
  password?: string;

  @Validator.IsString()
  @Validator.Length(2, 64)
  status?: "aktivan" | "neaktivan";

  @Validator.IsNumber()
  code: number;

  @Validator.IsIn(["muško", "žensko"])
  gender: "muško" | "žensko";
}
