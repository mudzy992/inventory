import {
  Column,
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  PrimaryGeneratedColumn,
} from "typeorm";
import { Article } from "./Article";
import { Feature } from "./Feature";

@Index("article_id", ["articleId"], {})
@Index("feature_id", ["featureId"], {})
@Entity("article_features", { schema: "inventory_v2" })
export class ArticleFeatures {
  @PrimaryGeneratedColumn({ type: "int", name: "article_feature_id" })
  articleFeatureId: number;

  @Column("int", { name: "article_id" })
  articleId: number;

  @Column("int", { name: "feature_id" })
  featureId: number;

  @Column("varchar", { name: "feature_value", length: 255 })
  featureValue: string;

  @ManyToOne(() => Article, (article) => article.articleFeatures, {
    onDelete: "NO ACTION",
    onUpdate: "NO ACTION",
  })
  @JoinColumn([{ name: "article_id", referencedColumnName: "articleId" }])
  article: Article;

  @ManyToOne(() => Feature, (feature) => feature.articleFeatures, {
    onDelete: "NO ACTION",
    onUpdate: "NO ACTION",
  })
  @JoinColumn([{ name: "feature_id", referencedColumnName: "featureId" }])
  feature: Feature;
}
