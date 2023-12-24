import {
  Column,
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  PrimaryGeneratedColumn,
} from "typeorm";
import { Article } from "./Article";
import { User } from "./User";
import { TicketGroup } from "./TicketGroup";

@Index("article_id", ["articleId"], {})
@Index("assigned_to", ["assignedTo"], {})
@Index("group_id", ["groupId"], {})
@Index("user_id", ["userId"], {})
@Entity("helpdesk_tickets", { schema: "inventory_test" })
export class HelpdeskTickets {
  @PrimaryGeneratedColumn({ type: "int", name: "ticket_id" })
  ticketId: number;

  @Column("int", { name: "user_id" })
  userId: number;

  @Column("int", { name: "article_id", nullable: true })
  articleId: number | null;

  @Column("int", { name: "group_id", nullable: true })
  groupId: number | null;

  @Column("varchar", { name: "title", length: 255 })
  title: string;

  @Column("varchar", { name: "description" })
  description: string;

  @Column("varchar", { name: "resolve_description" })
  resolveDescription: string;

  @Column("timestamp", {
    name: "created_at",
    nullable: true,
    default: () => "CURRENT_TIMESTAMP",
  })
  createdAt: Date | null;

  @Column("timestamp", { name: "due_date", nullable: true })
  dueDate: string;

  @Column("enum", {
    name: "status",
    enum: ["otvoren", "izvršenje", "zatvoren"],
    default: () => "'otvoren'",
  })
  status: "otvoren" | "izvršenje" | "zatvoren";

  @Column("int", { name: "assigned_to", nullable: true })
  assignedTo: number | null;

  @ManyToOne(() => Article, (article) => article.helpdeskTickets, {
    onDelete: "NO ACTION",
    onUpdate: "NO ACTION",
  })
  @JoinColumn([{ name: "article_id", referencedColumnName: "articleId" }])
  article: Article;

  @ManyToOne(() => User, (user) => user.helpdeskTickets, {
    onDelete: "NO ACTION",
    onUpdate: "NO ACTION",
  })
  @JoinColumn([{ name: "assigned_to", referencedColumnName: "userId" }])
  assignedTo2: User;

  @ManyToOne(() => TicketGroup, (ticketGroup) => ticketGroup.helpdeskTickets, {
    onDelete: "NO ACTION",
    onUpdate: "NO ACTION",
  })
  @JoinColumn([{ name: "group_id", referencedColumnName: "groupId" }])
  group: TicketGroup;

  @ManyToOne(() => User, (user) => user.helpdeskTickets2, {
    onDelete: "NO ACTION",
    onUpdate: "NO ACTION",
  })
  @JoinColumn([{ name: "user_id", referencedColumnName: "userId" }])
  user: User;
}
