import {
  Column,
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  OneToMany,
  PrimaryGeneratedColumn,
} from "typeorm";
import { Feature } from "./Feature";
import { Stock } from "./Stock";
import { Article } from "./Article";

@Index("parent_category_id", ["parentCategoryId"], {})
@Entity("category", { schema: "inventory_v2" })
export class Category {
  @PrimaryGeneratedColumn({ type: "int", name: "category_id" })
  categoryId: number;

  @Column("varchar", { name: "name", length: 255 })
  name: string;

  @Column("varchar", { name: "image_path", nullable: true, length: 255 })
  imagePath: string | null;

  @Column("int", { name: "parent_category_id", nullable: true })
  parentCategoryId: number | null;

  @OneToMany(() => Article, (article) => article.category)
  articles: Article[];

  @ManyToOne(() => Category, (category) => category.categories, {
    onDelete: "NO ACTION",
    onUpdate: "NO ACTION",
  })
  @JoinColumn([
    { name: "parent_category_id", referencedColumnName: "categoryId" },
  ])
  parentCategory: Category;

  @OneToMany(() => Category, (category) => category.parentCategory)
  categories: Category[];

  @OneToMany(() => Feature, (feature) => feature.category)
  features: Feature[];

  @OneToMany(() => Stock, (stock) => stock.category)
  stocks: Stock[];
}
