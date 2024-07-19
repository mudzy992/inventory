import { DepartmentJob } from "src/entities/DepartmentJob";
import { TicketGroup } from "src/entities/TicketGroup";
import { User } from "src/entities/User";

export class LocationDTO {
  locationId?: number;
  name?: string;
  code?: string | null;
  parentLocationId?: number | null;

  // Sva polja vezana za relacije ostavljamo kao opciona
  departmentJobs?: Partial<DepartmentJob>[];
  parentLocation?: Partial<LocationDTO>; // Ovde koristimo LocationDTO zbog potencijalne rekurzije
  locations?: Partial<LocationDTO>[];
  users?: Partial<User>[];
  ticketGroups?: Partial<TicketGroup>[];
}
