import { Column, Entity, Index, PrimaryGeneratedColumn } from "typeorm";

@Index("administrator_username", ["username"], { unique: true })
@Entity("administrator", { schema: "inventory" })
export class Administrator {
  @PrimaryGeneratedColumn({
    type: "int",
    name: "administrator_id",
    unsigned: true,
  })
  administratorId: number;

  @Column("varchar", { name: "username", unique: true, length: 32 })
  username: string;

  @Column("varchar", { name: "password_hash", length: 128 })
  passwordHash: string;
}
