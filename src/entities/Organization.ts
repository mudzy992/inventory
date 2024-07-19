import { Column, Entity, OneToMany, PrimaryGeneratedColumn } from "typeorm";
import { User } from "./User";

@Entity("organization", { schema: "inventory_v2" })
export class Organization {
  @PrimaryGeneratedColumn({ type: "int", name: "organization_id" })
  organizationId: number;

  @Column("varchar", { name: "name", length: 50 })
  name: string;

  @OneToMany(() => User, (user) => user.organization)
  users: User[];
}
