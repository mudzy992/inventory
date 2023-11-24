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
import { Location } from "./Location";

@Index("department_id", ["departmentId"], {})
@Index("job_id", ["jobId"], {})
@Index("location_id", ["locationId"], {})
@Entity("department_job", { schema: "inventory_v2" })
export class DepartmentJob {
  @PrimaryGeneratedColumn({ type: "int", name: "department_job_id" })
  departmentJobId: number;

  @Column("int", { name: "department_id" })
  departmentId: number;

  @Column("int", { name: "job_id" })
  jobId: number;

  @Column("int", { name: "location_id" })
  locationId: number;

  @ManyToOne(() => Department, (department) => department.departmentJobs, {
    onDelete: "NO ACTION",
    onUpdate: "NO ACTION",
  })
  @JoinColumn([{ name: "department_id", referencedColumnName: "departmentId" }])
  department: Department;

  @ManyToOne(() => Job, (job) => job.departmentJobs, {
    onDelete: "NO ACTION",
    onUpdate: "NO ACTION",
  })
  @JoinColumn([{ name: "job_id", referencedColumnName: "jobId" }])
  job: Job;

  @ManyToOne(() => Location, (location) => location.departmentJobs, {
    onDelete: "NO ACTION",
    onUpdate: "NO ACTION",
  })
  @JoinColumn([{ name: "location_id", referencedColumnName: "locationId" }])
  location: Location;
}
