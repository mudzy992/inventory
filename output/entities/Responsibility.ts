import {
  Column,
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  OneToMany,
  PrimaryGeneratedColumn,
} from "typeorm";
import { Article } from "./Article";
import { User } from "./User";
import { UserArticle } from "./UserArticle";

@Index("FK_104", ["articleId"], {})
@Index("FK_92", ["userId"], {})
@Index(
  "user_id_article_id_serial_number",
  ["userId", "articleId", "serialNumber"],
  { unique: true }
)
@Entity("responsibility", { schema: "inventory" })
export class Responsibility {
  @PrimaryGeneratedColumn({
    type: "int",
    name: "responsibility_id",
    unsigned: true,
  })
  responsibilityId: number;

  @Column("int", { name: "user_id", unsigned: true, default: () => "'0'" })
  userId: number;

  @Column("int", { name: "article_id", unsigned: true, default: () => "'0'" })
  articleId: number;

  @Column("int", { name: "value", default: () => "'0'" })
  value: number;

  @Column("enum", {
    name: "status",
    enum: ["zaduženo", "razduženo", "otpisano"],
    default: () => "'zaduženo'",
  })
  status: "zaduženo" | "razduženo" | "otpisano";

  @Column("timestamp", {
    name: "timestamp",
    default: () => "CURRENT_TIMESTAMP",
  })
  timestamp: Date;

  @Column("varchar", { name: "serial_number", length: 255 })
  serialNumber: string;

  @ManyToOne(() => Article, (article) => article.responsibilities, {
    onDelete: "RESTRICT",
    onUpdate: "CASCADE",
  })
  @JoinColumn([{ name: "article_id", referencedColumnName: "articleId" }])
  article: Article;

  @ManyToOne(() => User, (user) => user.responsibilities, {
    onDelete: "RESTRICT",
    onUpdate: "CASCADE",
  })
  @JoinColumn([{ name: "user_id", referencedColumnName: "userId" }])
  user: User;

  @OneToMany(() => UserArticle, (userArticle) => userArticle.responsibility)
  userArticles: UserArticle[];
}
