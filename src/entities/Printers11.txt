import {
  Column,
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  OneToMany,
  PrimaryGeneratedColumn,
} from "typeorm";
import { PrinterOid } from "./PrinterOid";
import { RentType } from "./RentType";

@Index("FK_printers_rent_type", ["rentalType"], {})
@Entity("printers", { schema: "inventory_v2" })
export class Printers {
  @PrimaryGeneratedColumn({ type: "int", name: "printer_id" })
  printerId: number;

  @Column("varchar", { name: "user_code", nullable: true, length: 255 })
  userCode: string | null;

  @Column("varchar", { name: "connection", nullable: true, length: 255 })
  connection: string | null;

  @Column("varchar", { name: "printer_type", nullable: true, length: 255 })
  printerType: string | null;

  @Column("varchar", { name: "serial_number", nullable: true, length: 255 })
  serialNumber: string | null;

  @Column("varchar", { name: "activity", nullable: true, length: 255 })
  activity: string | null;

  @Column("int", { name: "rental_type", default: () => "'5'" })
  rentalType: number;

  @Column("varchar", { name: "ownership", nullable: true, length: 255 })
  ownership: string | null;

  @Column("enum", {
    name: "status",
    nullable: true,
    enum: ["activated", "deactivated"],
    default: () => "'activated'",
  })
  status: "activated" | "deactivated" | null;

  @OneToMany(() => PrinterOid, (printerOid) => printerOid.printer)
  printerOs: PrinterOid[];

  @ManyToOne(() => RentType, (rentType) => rentType.printers, {
    onDelete: "NO ACTION",
    onUpdate: "NO ACTION",
  })
  @JoinColumn([{ name: "rental_type", referencedColumnName: "rentTypeId" }])
  rentalType2: RentType;
}
