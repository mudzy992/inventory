import { HelpdeskTicketService } from "src/services/helpdesk.tickets/helpdesk.tickets.service";
import { UserDTO } from "../user/user.dto";

export class CommentsDTO {
  commentId?: number;
  text?: string;
  userId?: number;
  createdAt?: Date;
  parentCommentId?: number | null;
  ticketId?: number;

  ticket?: Partial<HelpdeskTicketService>;
  parentComment?: Partial<CommentsDTO>;
  comments?: Partial<CommentsDTO>[];
  user?: Partial<UserDTO>;
}
