import {
  Column,
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  PrimaryGeneratedColumn,
} from "typeorm";
import { Department } from "./Department";
import { Job } from "./Job";

@Index("department_job_department_id", ["departmentId"], {})
@Index("department_job_job_id", ["jobId"], {})
@Entity("department_job", { schema: "inventory" })
export class DepartmentJob {
  @PrimaryGeneratedColumn({
    type: "int",
    name: "department_job_id",
    unsigned: true,
  })
  departmentJobId: number;

  @Column("int", {
    name: "department_id",
    unsigned: true,
    default: () => "'0'",
  })
  departmentId: number;

  @Column("int", { name: "job_id", unsigned: true, default: () => "'0'" })
  jobId: number;

  @ManyToOne(() => Department, (department) => department.departmentJobs, {
    onDelete: "RESTRICT",
    onUpdate: "CASCADE",
  })
  @JoinColumn([{ name: "department_id", referencedColumnName: "departmentId" }])
  department: Department;

  @ManyToOne(() => Job, (job) => job.departmentJobs, {
    onDelete: "RESTRICT",
    onUpdate: "CASCADE",
  })
  @JoinColumn([{ name: "job_id", referencedColumnName: "jobId" }])
  job: Job;
}
