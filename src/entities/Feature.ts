import {
  Column,
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  OneToMany,
  PrimaryGeneratedColumn,
} from "typeorm";
import { ArticleFeatures } from "./ArticleFeatures";
import { Category } from "./Category";
import { StockFeature } from "./StockFeature";

@Index("category_id", ["categoryId"], {})
@Entity("feature")
export class Feature {
  @PrimaryGeneratedColumn({ type: "int", name: "feature_id" })
  featureId: number;

  @Column("varchar", { name: "name", length: 255 })
  name: string;

  @Column("int", { name: "category_id" })
  categoryId: number;

  @OneToMany(
    () => ArticleFeatures,
    (articleFeatures) => articleFeatures.feature
  )
  articleFeatures: ArticleFeatures[];

  @ManyToOne(() => Category, (category) => category.features, {
    onDelete: "NO ACTION",
    onUpdate: "NO ACTION",
  })
  @JoinColumn([{ name: "category_id", referencedColumnName: "categoryId" }])
  category: Category;

  @OneToMany(() => StockFeature, (stockFeature) => stockFeature.feature)
  stockFeatures: StockFeature[];
}
