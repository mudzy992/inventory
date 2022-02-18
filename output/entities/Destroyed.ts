import {
  Column,
  Entity,
  Index,
  JoinColumn,
  OneToOne,
  PrimaryGeneratedColumn,
} from "typeorm";
import { Article } from "./Article";

@Index("article_id", ["articleId"], { unique: true })
@Entity("destroyed", { schema: "inventory" })
export class Destroyed {
  @PrimaryGeneratedColumn({ type: "int", name: "destroyed_id", unsigned: true })
  destroyedId: number;

  @Column("int", {
    name: "article_id",
    unique: true,
    unsigned: true,
    default: () => "'0'",
  })
  articleId: number;

  @Column("int", { name: "value", default: () => "'0'" })
  value: number;

  @Column("varchar", { name: "comment", nullable: true, length: 255 })
  comment: string | null;

  @Column("timestamp", {
    name: "timestamp",
    default: () => "CURRENT_TIMESTAMP",
  })
  timestamp: Date;

  @Column("int", { name: "user_id", unsigned: true, default: () => "'0'" })
  userId: number;

  @OneToOne(() => Article, (article) => article.destroyed, {
    onDelete: "RESTRICT",
    onUpdate: "CASCADE",
  })
  @JoinColumn([{ name: "article_id", referencedColumnName: "articleId" }])
  article: Article;
}
