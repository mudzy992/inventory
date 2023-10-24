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
import { Documents } from "./Documents";

@Index("article_id", ["articleId"], {})
@Index("user_id", ["userId"], {})
@Index("document_id", ["documentId"], {})
@Entity("article_timeline", { schema: "inventory_v2" })
export class ArticleTimeline {
  @PrimaryGeneratedColumn({ type: "int", name: "article_timeline_id" })
  articleTimelineId: number;

  @Column("int", { name: "article_id" })
  articleId: number;

  @Column("int", { name: "user_id" })
  userId: number;

  @Column("int", { name: "document_id", })
  documentId: number;

  @Column("varchar", { name: "serial_number", nullable: true, length: 50 })
  serialNumber: string | null;

  @Column("enum", {
    name: "status",
    nullable: true,
    enum: ["zaduženo", "razduženo", "otpisano"],
  })
  status: "zaduženo" | "razduženo" | "otpisano" | null;

  @Column("timestamp", {
    name: "timestamp",
    nullable: true,
    default: () => "CURRENT_TIMESTAMP",
  })
  timestamp: Date | null;

  @Column("varchar", { name: "inv_number", nullable: true, length: 50 })
  invNumber: string | null;

  @Column("text", { name: "comment", nullable: true })
  comment: string | null;

  @ManyToOne(() => Article, (article) => article.articleTimelines, {
    onDelete: "NO ACTION",
    onUpdate: "NO ACTION",
  })
  @JoinColumn([{ name: "article_id", referencedColumnName: "articleId" }])
  article: Article;

  @ManyToOne(() => User, (user) => user.articleTimelines, {
    onDelete: "NO ACTION",
    onUpdate: "NO ACTION",
  })
  @JoinColumn([{ name: "user_id", referencedColumnName: "userId" }])
  user: User;

  @ManyToOne(() => Documents, (documents) => documents.articleTimelines, {
    onDelete: "NO ACTION",
    onUpdate: "NO ACTION",
  })
  @JoinColumn([{ name: "document_id", referencedColumnName: "documentsId" }])
  document: Documents;
}
