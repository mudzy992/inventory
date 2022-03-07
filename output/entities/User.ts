import { Column, Entity, OneToMany, PrimaryGeneratedColumn } from "typeorm";
import { DebtItems } from "./DebtItems";
import { Destroyed } from "./Destroyed";
import { Responsibility } from "./Responsibility";
import { UserArticle } from "./UserArticle";

@Entity("user", { schema: "inventory" })
export class User {
  @PrimaryGeneratedColumn({ type: "int", name: "user_id", unsigned: true })
  userId: number;

  @Column("varchar", { name: "surname", length: 45, default: () => "'0'" })
  surname: string;

  @Column("varchar", { name: "forname", length: 45, default: () => "'0'" })
  forname: string;

  @Column("varchar", { name: "job_title", nullable: true, length: 45 })
  jobTitle: string | null;

  @Column("varchar", { name: "department", nullable: true, length: 45 })
  department: string | null;

  @Column("varchar", { name: "location", length: 45, default: () => "'0'" })
  location: string;

  @Column("varchar", { name: "email", length: 255 })
  email: string;

  @OneToMany(() => DebtItems, (debtItems) => debtItems.user)
  debtItems: DebtItems[];

  @OneToMany(() => Destroyed, (destroyed) => destroyed.user)
  destroyeds: Destroyed[];

  @OneToMany(() => Responsibility, (responsibility) => responsibility.user)
  responsibilities: Responsibility[];

  @OneToMany(() => UserArticle, (userArticle) => userArticle.user)
  userArticles: UserArticle[];
}
