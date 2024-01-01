import { TicketGroup } from "src/entities/TicketGroup";
import { User } from "src/entities/User";

export class ModeratorGroupMappingDTO {
  mappingId?: number;
  userId?: number;
  groupId?: number;

  group?: Partial<TicketGroup>;
  user?: Partial<User>;
}
