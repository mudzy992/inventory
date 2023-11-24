import {
  Column,
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  OneToMany,
  PrimaryGeneratedColumn,
} from "typeorm";
import { DepartmentJob } from "./DepartmentJob";
import { User } from "./User";

@Index("parent_department_id", ["parentDepartmentId"], {})
@Entity("department", { schema: "inventory_v2" })
export class Department {
  @PrimaryGeneratedColumn({ type: "int", name: "department_id" })
  departmentId: number;

  @Column("varchar", { name: "title", length: 255 })
  title: string;

  @Column("text", { name: "description", nullable: true })
  description: string | null;

  @Column("varchar", { name: "departmend_code", nullable: true, length: 50 })
  departmendCode: string | null;

  @Column("int", { name: "parent_department_id", nullable: true })
  parentDepartmentId: number | null;

  @ManyToOne(() => Department, (department) => department.departments, {
    onDelete: "NO ACTION",
    onUpdate: "NO ACTION",
  })
  @JoinColumn([
    { name: "parent_department_id", referencedColumnName: "departmentId" },
  ])
  parentDepartment: Department;

  @OneToMany(() => Department, (department) => department.parentDepartment)
  departments: Department[];

  @OneToMany(() => DepartmentJob, (departmentJob) => departmentJob.department)
  departmentJobs: DepartmentJob[];

  @OneToMany(() => User, (user) => user.department)
  users: User[];
}
