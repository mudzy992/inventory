import { Department } from "src/entities/Department";
import { Job } from "src/entities/Job";

export class DepartmentJobDTO {
  departmentJobId?: number;
  departmentId?: number;
  jobId?: number;
  locationId?: number;

  department?: Partial<Department>;
  job?: Partial<Job>;
  location?: Partial<Location>;
}
