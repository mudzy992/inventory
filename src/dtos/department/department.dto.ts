import { DepartmentJob } from "src/entities/DepartmentJob";
import { User } from "src/entities/User";

export class DepartmentDTO {
  departmentId?: number;
  title?: string;
  description?: string | null;
  departmendCode?: string | null;
  parentDepartmentId?: number | null;

  parentDepartment?: Partial<DepartmentDTO>; 
  departments?: Partial<DepartmentDTO>[];
  departmentJobs?: Partial<DepartmentJob>[];
  users?: Partial<User>[];
}
