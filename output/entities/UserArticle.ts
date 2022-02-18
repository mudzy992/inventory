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

@Index("user_id_article_id_status", ["userId", "articleId", "status"], {
  unique: true,
})
@Index("FK_104", ["articleId"], {})
@Index("FK_92", ["userId"], {})
@Entity("user_article", { schema: "inventory" })
export class UserArticle {
  @PrimaryGeneratedColumn({
    type: "int",
    name: "user_article_id",
    unsigned: true,
  })
  userArticleId: number;

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

  @ManyToOne(() => Article, (article) => article.userArticles, {
    onDelete: "RESTRICT",
    onUpdate: "CASCADE",
  })
  @JoinColumn([{ name: "article_id", referencedColumnName: "articleId" }])
  article: Article;

  @ManyToOne(() => User, (user) => user.userArticles, {
    onDelete: "RESTRICT",
    onUpdate: "CASCADE",
  })
  @JoinColumn([{ name: "user_id", referencedColumnName: "userId" }])
  user: User;
}
