import {
  Column,
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  OneToMany,
  PrimaryGeneratedColumn,
} from "typeorm";
import { Category } from "./Category";
import { ArticleFeature } from "./ArticleFeature";
import { Destroyed } from "./Destroyed";
import { Responsibility } from "./Responsibility";
import { Stock } from "./Stock";

@Index("fk_article_category_id", ["categoryId"], {})
@Entity("article", { schema: "inventory" })
export class Article {
  @PrimaryGeneratedColumn({ type: "int", name: "article_id", unsigned: true })
  articleId: number;

  @Column("varchar", { name: "name", length: 45, default: () => "'0'" })
  name: string;

  @Column("varchar", { name: "excerpt", length: 45, default: () => "'0'" })
  excerpt: string;

  @Column("varchar", { name: "description", length: 45, default: () => "'0'" })
  description: string;

  @Column("varchar", { name: "concract", length: 255, default: () => "'0'" })
  concract: string;

  @Column("int", { name: "category_id", unsigned: true, default: () => "'0'" })
  categoryId: number;

  @Column("varchar", { name: "comment", nullable: true, length: 255 })
  comment: string | null;

  @Column("varchar", { name: "sap_number", length: 50, default: () => "'0'" })
  sapNumber: string;

  @ManyToOne(() => Category, (category) => category.articles, {
    onDelete: "RESTRICT",
    onUpdate: "CASCADE",
  })
  @JoinColumn([{ name: "category_id", referencedColumnName: "categoryId" }])
  category: Category;

  @OneToMany(() => ArticleFeature, (articleFeature) => articleFeature.article)
  articleFeatures: ArticleFeature[];

  @OneToMany(() => Destroyed, (destroyed) => destroyed.article)
  destroyeds: Destroyed[];

  @OneToMany(() => Responsibility, (responsibility) => responsibility.article)
  responsibilities: Responsibility[];

  @OneToMany(() => Stock, (stock) => stock.article)
  stocks: Stock[];
}
