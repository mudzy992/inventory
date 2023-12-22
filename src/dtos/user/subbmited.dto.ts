// subbmited.dto.ts
import { Exclude } from "class-transformer";

export class SubbmitedDto {
  userId: number;
  surname: string;
  forname: string;
  fullname: string;
  localNumber: string;
  telephone: string;
  email: string;
  jobId: number;
  departmentId: number;
  locationId: number;
  registrationDate: Date;
  lastLoginDate: Date;
  status: "aktivan" | "neaktivan";
  code: number;
  gender: "muško" | "žensko";

  @Exclude()
  passwordHash: string;
}
