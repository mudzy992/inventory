import { Column, Entity, OneToMany, PrimaryGeneratedColumn } from "typeorm";
import { DepartmentJob } from "./DepartmentJob";
import { User } from "./User";

@Entity("job", { schema: "inventory" })
export class Job {
  @PrimaryGeneratedColumn({ type: "int", name: "job_id", unsigned: true })
  jobId: number;

  @Column("varchar", {
    name: "title",
    length: 250,
    default: () => "'undefined'",
  })
  title: string;

  @Column("varchar", { name: "description", nullable: true, length: 250 })
  description: string | null;

  @Column("varchar", {
    name: "job_code",
    length: 50,
    default: () => "'undefined'",
  })
  jobCode: string;

  @OneToMany(() => DepartmentJob, (departmentJob) => departmentJob.job)
  departmentJobs: DepartmentJob[];

  @OneToMany(() => User, (user) => user.job)
  users: User[];
}
