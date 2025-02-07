import { Column, Entity, PrimaryGeneratedColumn } from "typeorm";

@Entity("page_prices")
export class PagePrices {
  @PrimaryGeneratedColumn({ type: "int", name: "page_prices_id" })
  pagePricesId: number;

  @Column("decimal", {
    name: "blackAndWhitePrice",
    precision: 20,
    scale: 6,
    default: () => "'0.000000'",
  })
  blackAndWhitePrice: string;

  @Column("decimal", {
    name: "colorPrice",
    precision: 20,
    scale: 6,
    default: () => "'0.000000'",
  })
  colorPrice: string;

  @Column("decimal", {
    name: "scanPrice",
    precision: 20,
    scale: 6,
    default: () => "'0.000000'",
  })
  scanPrice: string;
}
