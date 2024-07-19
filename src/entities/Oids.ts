import { Column, Entity, OneToMany, PrimaryGeneratedColumn } from "typeorm";
import { PrinterOid } from "./PrinterOid";

@Entity("oids", { schema: "inventory_v2" })
export class Oids {
  @PrimaryGeneratedColumn({ type: "int", name: "oid_id" })
  oidId: number;

  @Column("varchar", { name: "code", length: 255 })
  code: string;

  @Column("varchar", { name: "name", length: 255 })
  name: string;

  @Column("enum", {
    name: "status",
    nullable: true,
    enum: ["activated", "deactivated"],
  })
  status: "activated" | "deactivated" | "deactivated";

  @OneToMany(() => PrinterOid, (printerOid) => printerOid.oid)
  printerOs: PrinterOid[];
}
