import { User } from "src/entities/User";

export class OrganizationDTO {
  organizationId?: number;
  name?: string;

  users?: Partial<User>[]
}