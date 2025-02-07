import { Column, Entity, OneToMany, PrimaryGeneratedColumn } from "typeorm";
import { PrinterOid } from "./PrinterOid";

@Entity("invoices")
export class Invoices {
  @PrimaryGeneratedColumn({ type: "int", name: "invoice_id" })
  invoiceId: number;

  @Column("timestamp", {
    name: "created_at",
    default: () => "CURRENT_TIMESTAMP",
  })
  createdAt: Date;

  @Column("int", { name: "invoice_number" })
  invoiceNumber: number;

  @Column("date", { name: "issue_date" })
  issueDate: string;

  @Column("varchar", { name: "customer", length: 255 })
  customer: string;

  @Column("decimal", { name: "rent_price", precision: 10, scale: 2 })
  rentPrice: string;

  @Column("decimal", { name: "total_amount", precision: 10, scale: 2 })
  totalAmount: string;

  @Column("enum", { name: "type", enum: ["Telefoni", "Printeri"] })
  type: "Telefoni" | "Printeri";

  @Column("enum", {
    name: "status",
    nullable: true,
    enum: ["izvršenje", "plaćeno"],
  })
  status: "izvršenje" | "plaćeno" | null;

  @Column({ type: 'int', default: 0 })
  blackAndWhite: number;

  @Column({ type: 'int', default: 0 })
  color: number;

  @Column({ type: 'int', default: 0 })
  scan: number;

  @OneToMany(() => PrinterOid, (printerOid) => printerOid.invoice)
  printerOs: PrinterOid[];
}
