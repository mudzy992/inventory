import * as Validator from 'class-validator';

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
  @Validator.Length(2, 50)
  localNumber: string;

  @Validator.IsString()
  @Validator.Length(2, 50)
  telephone: string | null; // Since it's nullable in the entity

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

  @Validator.IsIn(['aktivan', 'neaktivan'])
  status: 'aktivan' | 'neaktivan';

  @Validator.IsNumber()
  code: number;

  @Validator.IsIn(['muško', 'žensko'])
  gender: 'muško' | 'žensko';

}
