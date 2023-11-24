import {
  Column,
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  PrimaryGeneratedColumn,
} from "typeorm";
import { Feature } from "./Feature";
import { Stock } from "./Stock";

@Index("FK_stock_feature_feature", ["featureId"], {})
@Index("FK_stock_feature_stock", ["stockId"], {})
@Entity("stock_feature", { schema: "inventory_v2" })
export class StockFeature {
  @PrimaryGeneratedColumn({ type: "int", name: "stock_feature_id" })
  stockFeatureId: number;

  @Column("int", { name: "stock_id", default: () => "'0'" })
  stockId: number;

  @Column("int", { name: "feature_id", default: () => "'0'" })
  featureId: number;

  @Column("varchar", { name: "value", length: 255 })
  value: string;

  @ManyToOne(() => Feature, (feature) => feature.stockFeatures, {
    onDelete: "NO ACTION",
    onUpdate: "NO ACTION",
  })
  @JoinColumn([{ name: "feature_id", referencedColumnName: "featureId" }])
  feature: Feature;

  @ManyToOne(() => Stock, (stock) => stock.stockFeatures, {
    onDelete: "NO ACTION",
    onUpdate: "NO ACTION",
  })
  @JoinColumn([{ name: "stock_id", referencedColumnName: "stockId" }])
  stock: Stock;
}
