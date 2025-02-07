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
@Entity("documents")
export class Documents {
  @PrimaryGeneratedColumn({ type: "int", name: "documents_id" })
  documentsId: number;

  @Column("int", { name: "article_id" })
  articleId: number;

  @Column("varchar", { name: "path", nullable: true, length: 255 })
  path: string | null;

  @Column("varchar", { name: "signed_path", nullable: true, length: 255 })
  signed_path: string | null;

  @Column({ type: "int", name: "document_number" })
  documentNumber: number;

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
