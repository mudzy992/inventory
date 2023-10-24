import {
  Column,
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  OneToMany,
  PrimaryGeneratedColumn,
} from "typeorm";
import { ArticleTimeline } from "./ArticleTimeline";
import { Article } from "./Article";

@Index("article_id", ["articleId"], {})
@Entity("documents", { schema: "inventory_v2" })
export class Documents {
  @PrimaryGeneratedColumn({ type: "int", name: "documents_id" })
  documentsId: number;

  @Column("int", { name: "article_id" })
  articleId: number;

  @Column("varchar", { name: "path", nullable: true, length: 255 })
  path: string | null;

  @Column("varchar", { name: "document_number", nullable: true, length: 50 })
  documentNumber: string | null;

  @Column("timestamp", {
    name: "created_date",
    default: () => "CURRENT_TIMESTAMP",
  })
  createdDate: Date;

  @OneToMany(
    () => ArticleTimeline,
    (articleTimeline) => articleTimeline.document
  )
  articleTimelines: ArticleTimeline[];

  @ManyToOne(() => Article, (article) => article.documents, {
    onDelete: "NO ACTION",
    onUpdate: "NO ACTION",
  })
  @JoinColumn([{ name: "article_id", referencedColumnName: "articleId" }])
  article: Article;
}
