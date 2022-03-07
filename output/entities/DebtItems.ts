import {
  Column,
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  OneToMany,
  PrimaryGeneratedColumn,
} from "typeorm";
import { User } from "./User";
import { UserArticle } from "./UserArticle";

@Index(
  "article_id_user_id_timestamp_serial_number",
  ["articleId", "userId", "timestamp", "serialNumber"],
  { unique: true }
)
@Index("fk_debt_items_user_id", ["userId"], {})
@Entity("debt_items", { schema: "inventory" })
export class DebtItems {
  @PrimaryGeneratedColumn({
    type: "int",
    name: "debt_items_id",
    unsigned: true,
  })
  debtItemsId: number;

  @Column("int", { name: "article_id" })
  articleId: number;

  @Column("int", { name: "user_id", unsigned: true })
  userId: number;

  @Column("int", { name: "value" })
  value: number;

  @Column("varchar", { name: "comment", nullable: true, length: 255 })
  comment: string | null;

  @Column("timestamp", {
    name: "timestamp",
    default: () => "CURRENT_TIMESTAMP",
  })
  timestamp: Date;

  @Column("varchar", { name: "serial_number", nullable: true, length: 255 })
  serialNumber: string | null;

  @Column("varchar", {
    name: "status",
    length: 50,
    default: () => "'razduženo'",
  })
  status: string;

  @ManyToOne(() => User, (user) => user.debtItems, {
    onDelete: "RESTRICT",
    onUpdate: "CASCADE",
  })
  @JoinColumn([{ name: "user_id", referencedColumnName: "userId" }])
  user: User;

  @OneToMany(() => UserArticle, (userArticle) => userArticle.debt)
  userArticles: UserArticle[];
}
