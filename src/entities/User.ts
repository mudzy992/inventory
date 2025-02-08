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
import { Comments } from "./Comments";
import { HelpdeskTickets } from "./HelpdeskTickets";
import { ModeratorGroupMapping } from "./ModeratorGroupMapping";
import { UserRole } from "./UserRole";
import { Job } from "./Job";
import { Department } from "./Department";
import { Location } from "./Location";
import { Organization } from "./Organization";
import { UserToken } from "./UserToken";

@Index("department_id", ["departmentId"], {})
@Index("FK_user_user_role", ["roleId"], {})
@Index("job_id", ["jobId"], {})
@Index("location_id", ["locationId"], {})
@Index("user_ibfk_4", ["organizationId"], {})
@Entity("user")
export class User {
  @PrimaryGeneratedColumn({ type: "int", name: "user_id" })
  userId: number;

  @Column("varchar", { name: "surname", length: 255 })
  surname: string;

  @Column("varchar", { name: "forname", length: 255 })
  forname: string;

  @Column("varchar", { name: "fullname", nullable: true, length: 255 })
  fullname: string | null;

  @Column("varchar", { name: "local_number", length: 50 })
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
  lastLoginDate: string | null;

  @Column("enum", {
    name: "status",
    enum: ["aktivan", "neaktivan"],
    default: () => "'neaktivan'",
  })
  status: "aktivan" | "neaktivan";

  @Column("int", { name: "code" })
  code: number;

  @Column("enum", {
    name: "gender",
    nullable: true,
    enum: ["muško", "žensko"],
    default: () => "'muško'",
  })
  gender: "muško" | "žensko" | null;

  @Column("int", { name: "role_id", default: () => "'1'" })
  roleId: number;

  @Column("int", { name: "organization_id", nullable: true })
  organizationId: number | null;

  @Column("varchar", { name: "phone_ip", length: 255 })
  phoneIp: string;

  @OneToMany(() => Article, (article) => article.user)
  articles: Article[];

  @OneToMany(() => ArticleTimeline, (articleTimeline) => articleTimeline.user)
  articleTimelines: ArticleTimeline[];

  @OneToMany(
    () => ArticleTimeline,
    (articleTimeline) => articleTimeline.subbmited
  )
  articleTimelines2: ArticleTimeline[];

  @OneToMany(() => Comments, (comments) => comments.user)
  comments: Comments[];

  @OneToMany(
    () => HelpdeskTickets,
    (helpdeskTickets) => helpdeskTickets.assignedTo2
  )
  helpdeskTickets: HelpdeskTickets[];

  @OneToMany(() => HelpdeskTickets, (helpdeskTickets) => helpdeskTickets.user)
  helpdeskTickets2: HelpdeskTickets[];

  @OneToMany(
    () => ModeratorGroupMapping,
    (moderatorGroupMapping) => moderatorGroupMapping.user
  )
  moderatorGroupMappings: ModeratorGroupMapping[];

  @ManyToOne(() => UserRole, (userRole) => userRole.users, {
    onDelete: "NO ACTION",
    onUpdate: "NO ACTION",
  })
  @JoinColumn([{ name: "role_id", referencedColumnName: "roleId" }])
  role: UserRole;

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

  @ManyToOne(() => Organization, (organization) => organization.users, {
    onDelete: "NO ACTION",
    onUpdate: "NO ACTION",
  })
  @JoinColumn([
    { name: "organization_id", referencedColumnName: "organizationId" },
  ])
  organization: Organization;

  @OneToMany(() => UserToken, (userToken) => userToken.user)
  userTokens: UserToken[];
}
