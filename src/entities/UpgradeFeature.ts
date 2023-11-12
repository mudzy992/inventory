import {
  Column,
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  PrimaryGeneratedColumn,
} from "typeorm";
import { Article } from "./Article";

@Index("article_id", ["articleId"], {})
@Entity("upgrade_feature", { schema: "inventory_v2" })
export class UpgradeFeature {
  @PrimaryGeneratedColumn({ type: "int", name: "upgrade_feature_id" })
  upgradeFeatureId: number;

  @Column("varchar", { name: "name", length: 255 })
  name: string;

  @Column("varchar", {name: "value", length: 50})
  value: string;

  @Column("timestamp", {
    name: "timestamp",
    nullable: true,
    default: () => "CURRENT_TIMESTAMP",
  })
  timestamp: Date | null;

  @Column("text", { name: "comment", nullable: true })
  comment: string | null;

  @Column("varchar", { name: "serial_number", nullable: true, length: 50 })
  serialNumber: string | null;

  @Column("int", { name: "article_id" })
  articleId: number;

  @ManyToOne(() => Article, (article) => article.upgradeFeatures, {
    onDelete: "NO ACTION",
    onUpdate: "NO ACTION",
  })
  @JoinColumn([{ name: "article_id", referencedColumnName: "articleId" }])
  article: Article;
}
