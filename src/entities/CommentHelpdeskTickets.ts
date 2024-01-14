import {
  Column,
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  PrimaryGeneratedColumn,
} from "typeorm";
import { Comments } from "./Comments";
import { HelpdeskTickets } from "./HelpdeskTickets";

@Index("fk_comments_comment_id", ["commentId"], {})
@Index("fk_ticket_ticket_id", ["ticketId"], {})
@Entity("comment_helpdesk_tickets", { schema: "inventory_v2" })
export class CommentHelpdeskTickets {
  @PrimaryGeneratedColumn({ type: "int", name: "comment_tickets_id" })
  commentTicketsId: number;

  @Column("int", { name: "comment_id" })
  commentId: number;

  @Column("int", { name: "ticket_id" })
  ticketId: number;

  @ManyToOne(() => Comments, (comments) => comments.commentHelpdeskTickets, {
    onDelete: "NO ACTION",
    onUpdate: "NO ACTION",
  })
  @JoinColumn([{ name: "comment_id", referencedColumnName: "commentId" }])
  comment: Comments;

  @ManyToOne(
    () => HelpdeskTickets,
    (helpdeskTickets) => helpdeskTickets.commentHelpdeskTickets,
    { onDelete: "NO ACTION", onUpdate: "NO ACTION" }
  )
  @JoinColumn([{ name: "ticket_id", referencedColumnName: "ticketId" }])
  ticket: HelpdeskTickets;
}
