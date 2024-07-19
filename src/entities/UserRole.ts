import {
  Column,
  Entity,
  Index,
  OneToMany,
  PrimaryGeneratedColumn,
} from "typeorm";
import { User } from "./User";

@Index("role", ["role"], { unique: true })
@Entity("user_role", { schema: "inventory_test" })
export class UserRole {
  @PrimaryGeneratedColumn({ type: "int", name: "role_id" })
  roleId: number;

  @Column("varchar", { name: "role", unique: true, length: 50 })
  role: string;

  @OneToMany(() => User, (user) => user.role)
  users: User[];
}
