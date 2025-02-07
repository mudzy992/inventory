import { Column, Entity, OneToMany, PrimaryGeneratedColumn } from "typeorm";
import { DepartmentJob } from "./DepartmentJob";
import { User } from "./User";

@Entity("job")
export class Job {
  @PrimaryGeneratedColumn({ type: "int", name: "job_id" })
  jobId: number;

  @Column("varchar", { name: "title", length: 255 })
  title: string;

  @Column("text", { name: "description", nullable: true })
  description: string | null;

  @Column("varchar", { name: "job_code", nullable: true, length: 50 })
  jobCode: string | null;

  @OneToMany(() => DepartmentJob, (departmentJob) => departmentJob.job)
  departmentJobs: DepartmentJob[];

  @OneToMany(() => User, (user) => user.job)
  users: User[];
}
