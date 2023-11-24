import { Column, Entity, OneToMany, PrimaryGeneratedColumn } from "typeorm";
import { AdministratorToken } from "./AdministratorToken";

@Entity("administrator", { schema: "inventory_v2" })
export class Administrator {
  @PrimaryGeneratedColumn({ type: "int", name: "administrator_id" })
  administratorId: number;

  @Column("varchar", { name: "username", length: 255 })
  username: string;

  @Column("varchar", { name: "password_hash", length: 255 })
  passwordHash: string;

  @OneToMany(
    () => AdministratorToken,
    (administratorToken) => administratorToken.administrator
  )
  administratorTokens: AdministratorToken[];
}
