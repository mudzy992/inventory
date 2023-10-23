import {
  Column,
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  PrimaryGeneratedColumn,
} from "typeorm";
import { Administrator } from "./Administrator";

@Index("administrator_id", ["administratorId"], {})
@Entity("administrator_token", { schema: "inventory_v2" })
export class AdministratorToken {
  @PrimaryGeneratedColumn({ type: "int", name: "administrator_token_id" })
  administratorTokenId: number;

  @Column("int", { name: "administrator_id", nullable: true })
  administratorId: number | null;

  @Column("timestamp", {
    name: "created_at",
    nullable: true,
    default: () => "CURRENT_TIMESTAMP",
  })
  createdAt: Date | null;

  @Column("varchar", { name: "token", length: 255 })
  token: string;

  @Column("timestamp", { name: "expire_at", nullable: true })
  expireAt: string | null;

  @Column("tinyint", { name: "is_valid", nullable: true, width: 1 })
  isValid: number | null;

  @ManyToOne(
    () => Administrator,
    (administrator) => administrator.administratorTokens,
    { onDelete: "NO ACTION", onUpdate: "NO ACTION" }
  )
  @JoinColumn([
    { name: "administrator_id", referencedColumnName: "administratorId" },
  ])
  administrator: Administrator;
}
