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
import { Category } from "./Category";
import { StockFeature } from "./StockFeature";

@Index("FK_stock_category", ["categoryId"], {})
@Entity("stock", { schema: "inventory_v2" })
export class Stock {
  @PrimaryGeneratedColumn({ type: "int", name: "stock_id" })
  stockId: number;

  @Column("varchar", { name: "name", length: 255 })
  name: string;

  @Column("text", { name: "excerpt", nullable: true })
  excerpt: string | null;

  @Column("text", { name: "description", nullable: true })
  description: string | null;

  @Column("varchar", { name: "contract", nullable: true, length: 255 })
  contract: string | null;

  @Column("int", { name: "category_id" })
  categoryId: number;

  @Column("varchar", { name: "sap_number", length: 50 })
  sapNumber: string;

  @Column("int", { name: "value_on_contract", default: () => "'0'" })
  valueOnContract: number;

  @Column("int", { name: "value_available", default: () => "'0'" })
  valueAvailable: number;

  @Column("timestamp", { name: "timestamp", default: () => "'now()'" })
  timestamp: Date;

  @OneToMany(() => Article, (article) => article.stock)
  articles: Article[];

  @ManyToOne(() => Category, (category) => category.stocks, {
    onDelete: "NO ACTION",
    onUpdate: "NO ACTION",
  })
  @JoinColumn([{ name: "category_id", referencedColumnName: "categoryId" }])
  category: Category;

  @OneToMany(() => StockFeature, (stockFeature) => stockFeature.stock)
  stockFeatures: StockFeature[];
}
