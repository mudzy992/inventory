import { Column, Entity, OneToMany, PrimaryGeneratedColumn } from "typeorm";
import { Printers } from "./Printers";

@Entity("rent_type", { schema: "inventory_v2" })
export class RentType {
  @PrimaryGeneratedColumn({ type: "int", name: "rent_type_id" })
  rentTypeId: number;

  @Column("varchar", { name: "name", length: 50 })
  name: string;

  @Column("double", { name: "price", nullable: true, precision: 20, scale: 6 })
  price: number | null;

  @OneToMany(() => Printers, (printers) => printers.rentalType2)
  printers: Printers[];
}
