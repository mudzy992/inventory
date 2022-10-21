import { Column, Entity, OneToMany, PrimaryGeneratedColumn } from "typeorm";
import { DepartmentJob } from "./DepartmentJob";

@Entity("department", { schema: "inventory" })
export class Department {
  @PrimaryGeneratedColumn({
    type: "int",
    name: "department_id",
    unsigned: true,
  })
  departmentId: number;

  @Column("varchar", {
    name: "title",
    length: 250,
    default: () => "'undefined'",
  })
  title: string;

  @Column("varchar", { name: "description", nullable: true, length: 250 })
  description: string | null;

  @Column("varchar", {
    name: "departmend_code",
    length: 50,
    default: () => "'undefined'",
  })
  departmendCode: string;

  @OneToMany(() => DepartmentJob, (departmentJob) => departmentJob.department)
  departmentJobs: DepartmentJob[];
}
