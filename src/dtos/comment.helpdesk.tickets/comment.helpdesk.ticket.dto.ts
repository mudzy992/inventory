import { CommentsDTO } from "../comments/comment.dto";
import { HelpdeskTicketsDTO } from "../helpdesk.tickets/helpdesk.tickets.dto";
import { UserDTO } from "../user/user.dto";

export class CommentHelpdeskTicketsDTO {
  commentTicketsId?: number;
  commentId?: number;
  ticketId?: number;

  comment?: Partial<CommentsDTO>;
  ticket?: Partial<HelpdeskTicketsDTO>;
}
