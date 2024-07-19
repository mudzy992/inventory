import {
  Column,
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  OneToMany,
  PrimaryGeneratedColumn,
} from "typeorm";
import { Article } from "./Article";
import { Feature } from "./Feature";
import { Stock } from "./Stock";
import { TicketGroup } from "./TicketGroup";

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

  @Column("int", { name: "groupId" })
  groupId: number;

  @OneToMany(() => Article, (article) => article.category)
  articles: Article[];

  @ManyToOne(() => TicketGroup, (ticketGroup) => ticketGroup.categories, {
    onDelete: "NO ACTION",
    onUpdate: "NO ACTION",
  })
  @JoinColumn([{ name: "groupId", referencedColumnName: "groupId" }])
  group: TicketGroup;

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
