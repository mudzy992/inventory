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
import { Department } from "./Department";
import { Job } from "./Job";
import { Location } from "./Location";
import { UserArticle } from "./UserArticle";
import { Article } from "./Article";

@Index("fk_user_job_id", ["jobId"], {})
@Index("fk_user_department_id", ["departmentId"], {})
@Index("fk_user_location_id", ["locationId"], {})
@Entity("user", { schema: "inventory" })
export class User {
  @PrimaryGeneratedColumn({ type: "int", name: "user_id", unsigned: true })
  userId: number;

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

  @Column("int", { name: "job_id", unsigned: true })
  jobId: number;

  @Column("int", { name: "department_id", unsigned: true })
  departmentId: number;

  @Column("int", { name: "location_id", unsigned: true })
  locationId: number;

  @OneToMany(() => DebtItems, (debtItems) => debtItems.user)
  debtItems: DebtItems[];

  @OneToMany(() => Destroyed, (destroyed) => destroyed.user)
  destroyeds: Destroyed[];

  @OneToMany(() => Responsibility, (responsibility) => responsibility.user)
  responsibilities: Responsibility[];

  @ManyToOne(() => Department, (department) => department.users, {
    onDelete: "RESTRICT",
    onUpdate: "CASCADE",
  })
  @JoinColumn([{ name: "department_id", referencedColumnName: "departmentId" }])
  department: Department;

  @ManyToOne(() => Job, (job) => job.users, {
    onDelete: "RESTRICT",
    onUpdate: "CASCADE",
  })
  @JoinColumn([{ name: "job_id", referencedColumnName: "jobId" }])
  job: Job;

  @ManyToOne(() => Location, (location) => location.users, {
    onDelete: "RESTRICT",
    onUpdate: "CASCADE",
  })
  @JoinColumn([{ name: "location_id", referencedColumnName: "locationId" }])
  location: Location;

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
