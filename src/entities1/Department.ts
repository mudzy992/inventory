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

@Index("FK_department_department", ["parentDepartmentId"], {})
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

  @Column("int", {
    name: "parent_department_id",
    nullable: true,
    unsigned: true,
  })
  parentDepartmentId: number | null;

  @ManyToOne(() => Department, (department) => department.departments, {
    onDelete: "RESTRICT",
    onUpdate: "CASCADE",
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
