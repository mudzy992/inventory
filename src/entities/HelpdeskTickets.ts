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

@Index("user_id", ["userId"], {})
@Index("article_id", ["articleId"], {})
@Index("group_id", ["groupId"], {})
@Index("assigned_to", ["assignedTo"], {})
@Index("fk_ticket_parent_group", ["groupPartentId"], {})
@Entity("helpdesk_tickets", { schema: "inventory_v2" })
export class HelpdeskTickets {
  @PrimaryGeneratedColumn({ type: "int", name: "ticket_id" })
  ticketId: number;

  @Column("int", { name: "user_id" })
  userId: number;

  @Column("int", { name: "article_id", nullable: true })
  articleId: number | null;

  @Column("int", { name: "group_id" })
  groupId: number;

  @Column("int", { name: "group_partent_id", nullable: true })
  groupPartentId: number | null;

  @Column("text", { name: "description" })
  description: string;

  @Column("text", { name: "resolve_description", nullable: true })
  resolveDescription: string | null;

  @Column("timestamp", {
    name: "created_at",
    nullable: true,
    default: () => "CURRENT_TIMESTAMP",
  })
  createdAt: Date | null;

  @Column("timestamp", { name: "due_date", nullable: true })
  dueDate: Date | null;

  @Column("enum", {
    name: "status",
    enum: ["otvoren", "izvršenje", "zatvoren"],
    default: () => "'otvoren'",
  })
  status: "otvoren" | "izvršenje" | "zatvoren";

  @Column("int", { name: "assigned_to", nullable: true })
  assignedTo: number | null;

  @Column("timestamp", { name: "client_duo_date", nullable: true })
  clientDuoDate: Date | null;

  @Column("timestamp", { name: "resolve_date", nullable: true })
  resolveDate: Date | null;

  @Column("enum", {
    name: "priority",
    nullable: true,
    enum: [
      "Problem veće hitnosti ili VIP korisnik",
      "Problem u radu servisa (za sve korisnike u firmi)",
      "Poteškoće u radu grupe korisnika",
      "Povremene poteškoće u radu grupe korisnika",
      "Poteškoće u radu korisnika",
      "Potrebna pomoć korisniku",
      "Zahtjevi za izmjenu/doradu manje složenosti",
      "Zahtjevi za izmjenu/doradu veće složenosti",
    ],
    default: () => "'Problem u radu servisa (za sve korisnike u firmi)'",
  })
  priority:
    | "Problem veće hitnosti ili VIP korisnik"
    | "Problem u radu servisa (za sve korisnike u firmi)"
    | "Poteškoće u radu grupe korisnika"
    | "Povremene poteškoće u radu grupe korisnika"
    | "Poteškoće u radu korisnika"
    | "Potrebna pomoć korisniku"
    | "Zahtjevi za izmjenu/doradu manje složenosti"
    | "Zahtjevi za izmjenu/doradu veće složenosti"
    | null;

  @Column("bigint", { name: "resolve_timespand", nullable: true })
  resolveTimespand: string | null;

  @Column("enum", {
    name: "resolve_resolution",
    nullable: true,
    enum: [
      "Nemoguće riješiti ili je u koliziji sa standardom ili politikom",
      "Riješen - nije potrebna analiza uzroka",
      "Uzrok problema nije otklonjen - privremeno rješenje",
      "Zahtjev je povučen od strane korisnika",
    ],
  })
  resolveResolution:
    | "Nemoguće riješiti ili je u koliziji sa standardom ili politikom"
    | "Riješen - nije potrebna analiza uzroka"
    | "Uzrok problema nije otklonjen - privremeno rješenje"
    | "Zahtjev je povučen od strane korisnika"
    | null;

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

  @ManyToOne(() => TicketGroup, (ticketGroup) => ticketGroup.helpdeskTickets2, {
    onDelete: "NO ACTION",
    onUpdate: "NO ACTION",
  })
  @JoinColumn([
    { name: "group_partent_id", referencedColumnName: "parentGroupId" },
  ])
  groupPartent: TicketGroup;

  @ManyToOne(() => User, (user) => user.helpdeskTickets2, {
    onDelete: "NO ACTION",
    onUpdate: "NO ACTION",
  })
  @JoinColumn([{ name: "user_id", referencedColumnName: "userId" }])
  user: User;
}
