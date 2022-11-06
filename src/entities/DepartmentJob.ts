import {
  Column,
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  OneToMany,
  PrimaryGeneratedColumn,
} from "typeorm";
import { Department } from "./Department";
import { Job } from "./Job";
import { Location } from "./Location";

@Index("department_job_department_id", ["departmentId"], {})
@Index("department_job_job_id", ["jobId"], {})
@Index("location_id", ["locationId"], {})
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

  @Column("int", { name: "location_id", unsigned: true, default: () => "'0'" })
  locationId: number;

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

  @ManyToOne(() => Location, (location) => location.departmentJobs, {
    onDelete: "RESTRICT",
    onUpdate: "CASCADE",
  })
  @JoinColumn([{ name: "location_id", referencedColumnName: "locationId" }])
  location: Location;

}
