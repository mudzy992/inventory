import { Category } from "src/entities/Category";
import { LocationDTO } from "../location/location.dto";
import { HelpdeskTicketsDTO } from "../helpdesk.tickets/helpdesk.tickets.dto";
import { ModeratorGroupMappingDTO } from "../moderator.group.mapping/moderator.group.mapping.dto";

export class TicketGroupDTO {
  groupId?: number;
  groupName?: string;
  locationId?: number | null;
  parentGroupId?: number | null;

  categories?: Partial<Category>[];
  helpdeskTickets?: Partial<HelpdeskTicketsDTO>[];
  helpdeskTickets2?: Partial<HelpdeskTicketsDTO>[];
  moderatorGroupMappings?: Partial<ModeratorGroupMappingDTO>[];
  parentGroup?: Partial<TicketGroupDTO>;
  ticketGroups?: Partial<TicketGroupDTO>[];
  location?: Partial<LocationDTO>;
}
