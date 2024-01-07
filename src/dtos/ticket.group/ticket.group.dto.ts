import { Category } from "src/entities/Category";
import { ModeratorGroupMapping } from "src/entities/ModeratorGroupMapping";
import { LocationDTO } from "../location/location.dto";
import { HelpdeskTicketsDTO } from "../helpdesk.tickets/helpdesk.tickets.dto";
import { TicketGroup } from "src/entities/TicketGroup";

export class TicketGroupDTO {
  groupId?: number;
  groupName?: string;
  locationId?: number | null;
  parentGroupId?: number | null;

  categories?: Partial<Category>[];
  helpdeskTickets?: Partial<HelpdeskTicketsDTO>[];
  helpdeskTickets2?: Partial<HelpdeskTicketsDTO>[];
  moderatorGroupMappings?: Partial<ModeratorGroupMapping>[];
  parentGroup?: Partial<TicketGroupDTO>;
  ticketGroups?: Partial<TicketGroupDTO>[];
  location?: Partial<LocationDTO>;
}
