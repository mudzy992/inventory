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
import { ArticleFeature } from "./ArticleFeature";
import { ArticleTimeline } from "./ArticleTimeline";
import { Documents } from "./Documents";
import { UpgradeFeature } from "./UpgradeFeature";

@Index("user_id", ["userId"], {})
@Index("fk_article_stock", ["stockId"], {})
@Entity("article", { schema: "inventory_v2" })
export class Article {
  @PrimaryGeneratedColumn({ type: "int", name: "article_id" })
  articleId: number;

  @Column("varchar", { name: "serial_number", nullable: true, length: 50 })
  serialNumber: string | null;

  @Column("varchar", { name: "inv_number", nullable: true, length: 50 })
  invNumber: string | null;

  @Column("int", { name: "user_id" })
  userId: number;

  @Column("int", { name: "document_id" })
  documentId: number;

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

  @Column("int", { name: "stock_id", nullable: true })
  stockId: number | null;

  @Column("varchar", { name: "comment", nullable: true, length: 500 })
  comment: string | null;

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

  @ManyToOne(() => Stock, (stock) => stock.articles2, {
    onDelete: "CASCADE",
    onUpdate: "CASCADE",
  })
  @JoinColumn([{ name: "stock_id", referencedColumnName: "stockId" }])
  stock_2: Stock;

  @OneToMany(() => ArticleFeature, (articleFeature) => articleFeature.article)
  articleFeatures: ArticleFeature[];

  @OneToMany(
    () => ArticleTimeline,
    (articleTimeline) => articleTimeline.article
  )
  articleTimelines: ArticleTimeline[];

  @OneToMany(() => Documents, (documents) => documents.article)
  documents: Documents[];

  @OneToMany(() => UpgradeFeature, (upgradeFeature) => upgradeFeature.article)
  upgradeFeatures: UpgradeFeature[];
}
