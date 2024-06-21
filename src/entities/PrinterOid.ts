import {
  Column,
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  PrimaryGeneratedColumn,
} from "typeorm";
import { Invoices } from "./Invoices";
import { Oids } from "./Oids";
import { Printers } from "./Printers";

@Index("FK_printer_oid_printers", ["printerId"], {})
@Index("FK_printer_oid_oids", ["oidId"], {})
@Index("fk_invoice_id", ["invoiceId"], {})
@Entity("printer_oid", { schema: "inventory_v2" })
export class PrinterOid {
  @PrimaryGeneratedColumn({ type: "int", name: "printer_oid_id" })
  printerOidId: number;

  @Column("int", { name: "printer_id" })
  printerId: number;

  @Column("int", { name: "oid_id" })
  oidId: number;

  @Column("text", { name: "value", nullable: true })
  value: string | null;

  @Column("int", { name: "invoice_id", nullable: true })
  invoiceId: number | null;

  @ManyToOne(() => Invoices, (invoices) => invoices.printerOs, {
    onDelete: "CASCADE",
    onUpdate: "NO ACTION",
  })
  @JoinColumn([{ name: "invoice_id", referencedColumnName: "invoiceId" }])
  invoice: Invoices;

  @ManyToOne(() => Oids, (oids) => oids.printerOs, {
    onDelete: "NO ACTION",
    onUpdate: "NO ACTION",
  })
  @JoinColumn([{ name: "oid_id", referencedColumnName: "oidId" }])
  oid: Oids;

  @ManyToOne(() => Printers, (printers) => printers.printerOs, {
    onDelete: "NO ACTION",
    onUpdate: "NO ACTION",
  })
  @JoinColumn([{ name: "printer_id", referencedColumnName: "printerId" }])
  printer: Printers;
}
