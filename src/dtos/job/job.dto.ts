import { DepartmentJob } from "src/entities/DepartmentJob";
import { User } from "src/entities/User";

export class JobDTO {
  jobId?: number;
  title?: string;
  description?: string | null;
  jobCode?: string | null;

  departmentJobs?: Partial<DepartmentJob>[];
  users?: Partial<User>[];
}
