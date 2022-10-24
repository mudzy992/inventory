import {
  Column,
  Entity,
  Index,
  JoinColumn,
  JoinTable,
  ManyToMany,
  ManyToOne,
  OneToMany,
  PrimaryGeneratedColumn,
} from "typeorm";
import { DebtItems } from "./DebtItems";
import { Destroyed } from "./Destroyed";
import { Responsibility } from "./Responsibility";
import { DepartmentJob } from "./DepartmentJob";
import { UserArticle } from "./UserArticle";
import { Article } from "./Article";

@Index("FK_user_department_job", ["departmentJobId"], {})
@Entity("user", { schema: "inventory" })
export class User {
  @PrimaryGeneratedColumn({ type: "int", name: "user_id", unsigned: true })
  userId: number;

  @Column("int", { name: "department_job_id", unsigned: true })
  departmentJobId: number;

  @Column("varchar", { name: "surname", length: 64, default: () => "'0'" })
  surname: string;

  @Column("varchar", { name: "forname", length: 64, default: () => "'0'" })
  forname: string;

  @Column("varchar", { name: "fullname", nullable: true, length: 50 })
  fullname: string | null;

  @Column("varchar", { name: "local_number", nullable: true, length: 50 })
  localNumber: string | null;

  @Column("varchar", { name: "telephone", nullable: true, length: 50 })
  telephone: string | null;

  @Column("varchar", { name: "email", length: 255 })
  email: string;

  @Column("varchar", { name: "password_hash", length: 255 })
  passwordHash: string;

  @OneToMany(() => DebtItems, (debtItems) => debtItems.user)
  debtItems: DebtItems[];

  @OneToMany(() => Destroyed, (destroyed) => destroyed.user)
  destroyeds: Destroyed[];

  @OneToMany(() => Responsibility, (responsibility) => responsibility.user)
  responsibilities: Responsibility[];

  @ManyToOne(() => DepartmentJob, (departmentJob) => departmentJob.users, {
    onDelete: "RESTRICT",
    onUpdate: "CASCADE",
  })
  @JoinColumn([
    { name: "department_job_id", referencedColumnName: "departmentJobId" },
  ])
  departmentJob: DepartmentJob;

  @OneToMany(() => UserArticle, (userArticle) => userArticle.user)
  userArticles: UserArticle[];

  @ManyToMany((type) => Article, (article) => article.userDetails)
  @JoinTable({
    name: 'responsibility',
    joinColumn: { name: 'user_id', referencedColumnName: 'userId' },
    inverseJoinColumn: {
      name: 'article_id',
      referencedColumnName: 'articleId',
    },
  })
  articles: Article[];
}
