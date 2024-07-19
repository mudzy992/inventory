import { Body, Controller, Post, UseGuards } from "@nestjs/common";
import { Crud } from "@nestjsx/crud";
import { AddNewDepartmentJobDto } from "src/dtos/departmentJob/add.new.department.job.dto";
import { DepartmentJob } from "src/entities/DepartmentJob";
import { AllowToRoles } from "src/misc/allow.to.roles.descriptor";
import { ApiResponse } from "src/misc/api.response.class";
import { RoleCheckedGuard } from "src/misc/role.checker.guard";
import { DepartmentJobService } from "src/services/departmentJob/department.job.service";

@Controller("api/departmentJob")
@Crud({
  model: {
    type: DepartmentJob,
  },
  params: {
    id: {
      field: "departmentJobId",
      type: "number",
      primary: true,
    },
  },
  query: {
    join: {
      department: {
        eager: true,
      },
      job: {
        eager: true,
      },
      location: {
        eager: true,
      },
      users: {
        eager: true,
        exclude: ["passwordHash"],
      },
    },
  },
})
export class DepartmentJobController {
  constructor(public service: DepartmentJobService) {}
  @Post()
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles("administrator", "moderator")
  async createNewDepartmentJob(
    @Body() data: AddNewDepartmentJobDto
  ): Promise<DepartmentJob | ApiResponse> {
    return await this.service.createNewDepartmentJob(data);
  }
}
