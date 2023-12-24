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
import { Stock } from "./Stock";
import { Category } from "./Category";
import { ArticleTimeline } from "./ArticleTimeline";
import { Documents } from "./Documents";
import { UpgradeFeature } from "./UpgradeFeature";
import { HelpdeskTickets } from "./HelpdeskTickets";

@Index("user_id", ["userId"], {})
@Index("fk_article_stock", ["stockId"], {})
@Index("article_ibfk_3", ["categoryId"], {})
@Entity("article", { schema: "inventory_v2" })
export class Article {
  @PrimaryGeneratedColumn({ type: "int", name: "article_id" })
  articleId: number;

  @Column("varchar", { name: "serial_number", length: 50 })
  serialNumber: string;

  @Column("varchar", { name: "inv_number", length: 50 })
  invNumber: string;

  @Column("int", { name: "user_id", nullable: true })
  userId: number | null;

  @Column("int", { name: "document_id", nullable: true })
  documentId: number | null;

  @Column("enum", {
    name: "status",
    enum: ["zaduženo", "razduženo", "otpisano"],
  })
  status: "zaduženo" | "razduženo" | "otpisano";

  @Column("timestamp", {
    name: "timestamp",
    nullable: true,
    default: () => "CURRENT_TIMESTAMP",
  })
  timestamp: Date | null;

  @Column("int", { name: "stock_id" })
  stockId: number;

  @Column("text", { name: "comment", nullable: true })
  comment: string | null;

  @Column("int", { name: "category_id", nullable: true })
  categoryId: number | null;

  @ManyToOne(() => User, (user) => user.articles, {
    onDelete: "NO ACTION",
    onUpdate: "NO ACTION",
  })
  @JoinColumn([{ name: "user_id", referencedColumnName: "userId" }])
  user: User;

  @ManyToOne(() => Stock, (stock) => stock.articles, {
    onDelete: "NO ACTION",
    onUpdate: "NO ACTION",
  })
  @JoinColumn([{ name: "stock_id", referencedColumnName: "stockId" }])
  stock: Stock;

  @ManyToOne(() => Category, (category) => category.articles, {
    onDelete: "NO ACTION",
    onUpdate: "NO ACTION",
  })
  @JoinColumn([{ name: "category_id", referencedColumnName: "categoryId" }])
  category: Category;

  @OneToMany(
    () => ArticleTimeline,
    (articleTimeline) => articleTimeline.article
  )
  articleTimelines: ArticleTimeline[];

  @OneToMany(() => Documents, (documents) => documents.article)
  documents: Documents[];

  @OneToMany(
    () => HelpdeskTickets,
    (helpdeskTickets) => helpdeskTickets.article
  )
  helpdeskTickets: HelpdeskTickets[];

  @OneToMany(() => UpgradeFeature, (upgradeFeature) => upgradeFeature.article)
  upgradeFeatures: UpgradeFeature[];
}
