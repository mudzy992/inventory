import {
  Column,
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  PrimaryGeneratedColumn,
} from "typeorm";
import { Article } from "./Article";

@Index(
  "fk_upgrade_feature_serial_number_user_article_serial_number",
  ["serialNumber"],
  {}
)
@Index("upgrade_feature_article_id_article_article_id", ["articleId"], {})
@Entity("upgrade_feature", { schema: "inventory" })
export class UpgradeFeature {
  @PrimaryGeneratedColumn({
    type: "int",
    name: "upgrade_feature_id",
    unsigned: true,
  })
  upgradeFeatureId: number;

  @Column("varchar", { name: "name", length: 50 })
  name: string;

  @Column("varchar", { name: "value", length: 50 })
  value: string;

  @Column("timestamp", {
    name: "timestamp",
    default: () => "CURRENT_TIMESTAMP",
  })
  timestamp: Date;

  @Column("varchar", { name: "comment", length: 255 })
  comment: string;

  @Column("varchar", { name: "serial_number", length: 50 })
  serialNumber: string;

  @Column("int", { name: "article_id", unsigned: true })
  articleId: number;

  @ManyToOne(() => Article, (article) => article.upgradeFeatures, {
    onDelete: "RESTRICT",
    onUpdate: "CASCADE",
  })
  @JoinColumn([{ name: "article_id", referencedColumnName: "articleId" }])
  article: Article;
}
