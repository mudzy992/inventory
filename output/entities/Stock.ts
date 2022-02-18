import {
  Column,
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  PrimaryGeneratedColumn,
} from "typeorm";
import { Article } from "./Article";

@Index("fk_stock_article_id", ["articleId"], {})
@Entity("stock", { schema: "inventory" })
export class Stock {
  @PrimaryGeneratedColumn({ type: "int", name: "stock_id", unsigned: true })
  stockId: number;

  @Column("int", { name: "article_id", unsigned: true, default: () => "'0'" })
  articleId: number;

  @Column("int", { name: "value_on_concract", default: () => "'0'" })
  valueOnConcract: number;

  @Column("int", { name: "value_available", default: () => "'0'" })
  valueAvailable: number;

  @Column("timestamp", {
    name: "timestamp",
    default: () => "CURRENT_TIMESTAMP",
  })
  timestamp: Date;

  @Column("varchar", { name: "sap_number", length: 50, default: () => "'0'" })
  sapNumber: string;

  @ManyToOne(() => Article, (article) => article.stocks, {
    onDelete: "RESTRICT",
    onUpdate: "CASCADE",
  })
  @JoinColumn([{ name: "article_id", referencedColumnName: "articleId" }])
  article: Article;
}
