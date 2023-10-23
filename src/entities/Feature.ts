import {
  Column,
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  OneToMany,
  PrimaryGeneratedColumn,
} from "typeorm";
import { ArticleFeature } from "./ArticleFeature";
import { Category } from "./Category";

@Index("category_id", ["categoryId"], {})
@Entity("feature", { schema: "inventory_v2" })
export class Feature {
  @PrimaryGeneratedColumn({ type: "int", name: "feature_id" })
  featureId: number;

  @Column("varchar", { name: "name", length: 255 })
  name: string;

  @Column("int", { name: "category_id" })
  categoryId: number;

  @OneToMany(() => ArticleFeature, (articleFeature) => articleFeature.feature)
  articleFeatures: ArticleFeature[];

  @ManyToOne(() => Category, (category) => category.features, {
    onDelete: "NO ACTION",
    onUpdate: "NO ACTION",
  })
  @JoinColumn([{ name: "category_id", referencedColumnName: "categoryId" }])
  category: Category;
}
