import {
  Column,
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  OneToMany,
  PrimaryGeneratedColumn,
} from "typeorm";
import { DebtItems } from "./DebtItems";
import { Destroyed } from "./Destroyed";
import { Article } from "./Article";
import { Responsibility } from "./Responsibility";
import { UserArticle } from "./UserArticle";

@Index("fk_documents_article_id", ["articleId"], {})
@Entity("documents", { schema: "inventory" })
export class Documents {
  @PrimaryGeneratedColumn({ type: "int", name: "documents_id", unsigned: true })
  documentsId: number;

  @Column("int", { name: "article_id", unsigned: true })
  articleId: number;

  @Column("varchar", { name: "path", length: 255 })
  path: string;

  @Column("int", { name: "document_number", default: () => "'0'" })
  documentNumber: number;

  @OneToMany(() => DebtItems, (debtItems) => debtItems.document)
  debtItems: DebtItems[];

  @OneToMany(() => Destroyed, (destroyed) => destroyed.document)
  destroyeds: Destroyed[];

  @ManyToOne(() => Article, (article) => article.documents, {
    onDelete: "RESTRICT",
    onUpdate: "CASCADE",
  })
  @JoinColumn([{ name: "article_id", referencedColumnName: "articleId" }])
  article: Article;

  @OneToMany(() => Responsibility, (responsibility) => responsibility.document)
  responsibilities: Responsibility[];

  @OneToMany(() => UserArticle, (userArticle) => userArticle.document)
  userArticles: UserArticle[];
}
