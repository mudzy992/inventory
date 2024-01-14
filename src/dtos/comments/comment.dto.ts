import { CommentHelpdeskTicketsDTO } from "../comment.helpdesk.tickets/comment.helpdesk.ticket.dto";
import { UserDTO } from "../user/user.dto";

export class CommentsDTO {
  commentId?: number;
  text?: string;
  userId?: number;
  createdAt?: Date;
  parentCommentId?: number | null;

  commentHelpdeskTickets?: Partial<CommentHelpdeskTicketsDTO>[];
  parentComment?: Partial<CommentsDTO>;
  comments?: Partial<CommentsDTO>[];
  user?: Partial<UserDTO>;
}
