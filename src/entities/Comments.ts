import {
  Column,
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  OneToMany,
  PrimaryGeneratedColumn,
} from "typeorm";
import { HelpdeskTickets } from "./HelpdeskTickets";
import { User } from "./User";

@Index("fk_helpdesk_ticket_id", ["ticketId"], {})
@Index("fk_parent_comment_id", ["parentCommentId"], {})
@Index("fk_user_user_id", ["userId"], {})
@Entity("comments", { schema: "inventory_v2" })
export class Comments {
  @PrimaryGeneratedColumn({ type: "int", name: "comment_id" })
  commentId: number;

  @Column("varchar", { name: "text", length: 255 })
  text: string;

  @Column("int", { name: "user_id" })
  userId: number;

  @Column("timestamp", {
    name: "created_at",
    default: () => "CURRENT_TIMESTAMP",
  })
  createdAt: Date;

  @Column("int", { name: "parent_comment_id", nullable: true })
  parentCommentId: number | null;

  @Column("int", { name: "ticket_id" })
  ticketId: number;

  @ManyToOne(
    () => HelpdeskTickets,
    (helpdeskTickets) => helpdeskTickets.comments,
    { onDelete: "NO ACTION", onUpdate: "NO ACTION" }
  )
  @JoinColumn([{ name: "ticket_id", referencedColumnName: "ticketId" }])
  ticket: HelpdeskTickets;

  @ManyToOne(() => Comments, (comments) => comments.comments, {
    onDelete: "NO ACTION",
    onUpdate: "NO ACTION",
  })
  @JoinColumn([
    { name: "parent_comment_id", referencedColumnName: "commentId" },
  ])
  parentComment: Comments;

  @OneToMany(() => Comments, (comments) => comments.parentComment)
  comments: Comments[];

  @ManyToOne(() => User, (user) => user.comments, {
    onDelete: "NO ACTION",
    onUpdate: "NO ACTION",
  })
  @JoinColumn([{ name: "user_id", referencedColumnName: "userId" }])
  user: User;
}
