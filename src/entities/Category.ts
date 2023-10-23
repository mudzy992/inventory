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
}
