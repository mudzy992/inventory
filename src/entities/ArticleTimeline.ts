import {
  Column,
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  PrimaryGeneratedColumn,
} from "typeorm";
import { Article } from "./Article";
import { Documents } from "./Documents";
import { User } from "./User";

@Index("fk_article_timeline_article", ["articleId"], {})
@Index("fk_article_timeline_documents", ["documentId"], {})
@Index("fk_article_timeline_user", ["userId"], {})
@Index(
  "serial_number_status_timestamp",
  ["serialNumber", "status", "timestamp"],
  { unique: true }
)
@Entity("article_timeline", { schema: "inventory" })
export class ArticleTimeline {
  @PrimaryGeneratedColumn({
    type: "int",
    name: "article_timeline_id",
    unsigned: true,
  })
  articleTimelineId: number;

  @Column("int", { name: "article_id", unsigned: true })
  articleId: number;

  @Column("int", { name: "user_id", unsigned: true })
  userId: number;

  @Column("int", { name: "document_id", unsigned: true })
  documentId: number;

  @Column("varchar", { name: "serial_number", length: 50 })
  serialNumber: string;

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

  @Column("varchar", { name: "inv_broj", length: 50 })
  invBroj: string;

  @Column("varchar", { name: "comment", nullable: true, length: 250 })
  comment: string | null;

  @ManyToOne(() => Article, (article) => article.articleTimelines, {
    onDelete: "RESTRICT",
    onUpdate: "CASCADE",
  })
  @JoinColumn([{ name: "article_id", referencedColumnName: "articleId" }])
  article: Article;

  @ManyToOne(() => Documents, (documents) => documents.articleTimelines, {
    onDelete: "RESTRICT",
    onUpdate: "CASCADE",
  })
  @JoinColumn([{ name: "document_id", referencedColumnName: "documentsId" }])
  document: Documents;

  @ManyToOne(() => User, (user) => user.articleTimelines, {
    onDelete: "RESTRICT",
    onUpdate: "CASCADE",
  })
  @JoinColumn([{ name: "user_id", referencedColumnName: "userId" }])
  user: User;
}
