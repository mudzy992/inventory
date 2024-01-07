import { User } from "src/entities/User";
import { TicketGroupDTO } from "../ticket.group/ticket.group.dto";

export class ModeratorGroupMappingDTO {
  mappingId?: number;
  userId?: number;
  groupId?: number;

  group?: Partial<TicketGroupDTO>;
  user?: Partial<User>;
}
