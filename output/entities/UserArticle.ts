import {
  Column,
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  PrimaryGeneratedColumn,
} from "typeorm";
import { DebtItems } from "./DebtItems";
import { Destroyed } from "./Destroyed";
import { Responsibility } from "./Responsibility";
import { User } from "./User";

@Index("fk_user_article_debt_id", ["debtId"], {})
@Index("fk_user_article_destroy_id", ["destroyId"], {})
@Index("fk_user_article_responsibility_id", ["responsibilityId"], {})
@Index("fk_user_article_user_id", ["userId"], {})
@Index("serial_number_status", ["serialNumber", "status"], { unique: true })
@Entity("user_article", { schema: "inventory" })
export class UserArticle {
  @PrimaryGeneratedColumn({
    type: "int",
    name: "user_article_id",
    unsigned: true,
  })
  userArticleId: number;

  @Column("int", { name: "article_id", unsigned: true })
  articleId: number;

  @Column("int", { name: "responsibility_id", nullable: true, unsigned: true })
  responsibilityId: number | null;

  @Column("int", { name: "debt_id", nullable: true, unsigned: true })
  debtId: number | null;

  @Column("int", { name: "destroy_id", nullable: true, unsigned: true })
  destroyId: number | null;

  @Column("int", { name: "user_id", nullable: true, unsigned: true })
  userId: number | null;

  @Column("varchar", { name: "serial_number", length: 255 })
  serialNumber: string;

  @Column("enum", {
    name: "status",
    nullable: true,
    enum: ["zaduženo", "razduženo", "otpisano"],
    default: () => "'zaduženo'",
  })
  status: "zaduženo" | "razduženo" | "otpisano" | null;

  @Column("timestamp", {
    name: "timestamp",
    nullable: true,
    default: () => "CURRENT_TIMESTAMP",
  })
  timestamp: Date | null;

  @ManyToOne(() => DebtItems, (debtItems) => debtItems.userArticles, {
    onDelete: "SET NULL",
    onUpdate: "CASCADE",
  })
  @JoinColumn([{ name: "debt_id", referencedColumnName: "debtItemsId" }])
  debt: DebtItems;

  @ManyToOne(() => Destroyed, (destroyed) => destroyed.userArticles, {
    onDelete: "RESTRICT",
    onUpdate: "CASCADE",
  })
  @JoinColumn([{ name: "destroy_id", referencedColumnName: "destroyedId" }])
  destroy: Destroyed;

  @ManyToOne(
    () => Responsibility,
    (responsibility) => responsibility.userArticles,
    { onDelete: "SET NULL", onUpdate: "CASCADE" }
  )
  @JoinColumn([
    { name: "responsibility_id", referencedColumnName: "responsibilityId" },
  ])
  responsibility: Responsibility;

  @ManyToOne(() => User, (user) => user.userArticles, {
    onDelete: "RESTRICT",
    onUpdate: "CASCADE",
  })
  @JoinColumn([{ name: "user_id", referencedColumnName: "userId" }])
  user: User;
}