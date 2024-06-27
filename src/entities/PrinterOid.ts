import {
  Column,
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  PrimaryGeneratedColumn,
} from "typeorm";
import { Invoices } from "./Invoices";
import { Article } from "./Article";
import { Oids } from "./Oids";

@Index("fk_invoice_id", ["invoiceId"], {})
@Index("FK_printer_oid_oids", ["oidId"], {})
@Index("FK_printer_oid_printers", ["articleId"], {})
@Entity("printer_oid", { schema: "inventory_v2" })
export class PrinterOid {
  @PrimaryGeneratedColumn({ type: "int", name: "printer_oid_id" })
  printerOidId: number;

  @Column("int", { name: "article_id" })
  articleId: number;

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

  @ManyToOne(() => Article, (article) => article.printerOs, {
    onDelete: "NO ACTION",
    onUpdate: "NO ACTION",
  })
  @JoinColumn([{ name: "article_id", referencedColumnName: "articleId" }])
  article: Article;

  @ManyToOne(() => Oids, (oids) => oids.printerOs, {
    onDelete: "NO ACTION",
    onUpdate: "NO ACTION",
  })
  @JoinColumn([{ name: "oid_id", referencedColumnName: "oidId" }])
  oid: Oids;
}
