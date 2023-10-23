import {
  Column,
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  OneToMany,
  PrimaryGeneratedColumn,
} from "typeorm";
import { Article } from "./Article";
import { ArticleTimeline } from "./ArticleTimeline";
import { Job } from "./Job";
import { Department } from "./Department";
import { Location } from "./Location";
import { UserToken } from "./UserToken";

@Index("local_number", ["localNumber"], { unique: true })
@Index("job_id", ["jobId"], {})
@Index("department_id", ["departmentId"], {})
@Index("location_id", ["locationId"], {})
@Entity("user", { schema: "inventory_v2" })
export class User {
  @PrimaryGeneratedColumn({ type: "int", name: "user_id" })
  userId: number;

  @Column("varchar", { name: "surname", length: 255 })
  surname: string;

  @Column("varchar", { name: "forname", length: 255 })
  forname: string;

  @Column("varchar", { name: "fullname", length: 255 })
  fullname: string;

  @Column("varchar", { name: "local_number", unique: true, length: 50 })
  localNumber: string;

  @Column("varchar", { name: "telephone", nullable: true, length: 50 })
  telephone: string | null;

  @Column("varchar", { name: "email", nullable: true, length: 255 })
  email: string | null;

  @Column("varchar", { name: "password_hash", length: 255 })
  passwordHash: string;

  @Column("int", { name: "job_id" })
  jobId: number;

  @Column("int", { name: "department_id" })
  departmentId: number;

  @Column("int", { name: "location_id" })
  locationId: number;

  @Column("timestamp", {
    name: "registration_date",
    nullable: true,
    default: () => "CURRENT_TIMESTAMP",
  })
  registrationDate: Date | null;

  @Column("timestamp", { name: "last_login_date", nullable: true })
  lastLoginDate: Date | null;

  @Column("enum", {
    name: "status",
    enum: ["aktivan", "neaktivan"],
    default: () => "'neaktivan'",
  })
  status: "aktivan" | "neaktivan";

  @OneToMany(() => Article, (article) => article.user)
  articles: Article[];

  @OneToMany(() => ArticleTimeline, (articleTimeline) => articleTimeline.user)
  articleTimelines: ArticleTimeline[];

  @ManyToOne(() => Job, (job) => job.users, {
    onDelete: "NO ACTION",
    onUpdate: "NO ACTION",
  })
  @JoinColumn([{ name: "job_id", referencedColumnName: "jobId" }])
  job: Job;

  @ManyToOne(() => Department, (department) => department.users, {
    onDelete: "NO ACTION",
    onUpdate: "NO ACTION",
  })
  @JoinColumn([{ name: "department_id", referencedColumnName: "departmentId" }])
  department: Department;

  @ManyToOne(() => Location, (location) => location.users, {
    onDelete: "NO ACTION",
    onUpdate: "NO ACTION",
  })
  @JoinColumn([{ name: "location_id", referencedColumnName: "locationId" }])
  location: Location;

  @OneToMany(() => UserToken, (userToken) => userToken.user)
  userTokens: UserToken[];
}
