import { Body, Controller, Delete, Get, Param, Patch, Post, UseGuards } from "@nestjs/common";
import { Crud } from "@nestjsx/crud";
import { AddNewDepartmentDto } from "src/dtos/department/add.new.department.dto";
import { DepartmentDTO } from "src/dtos/department/department.dto";
import { EditDepartmentDto } from "src/dtos/department/edit.department.dto";
import { Department } from "src/entities/Department";
import { AllowToRoles } from "src/misc/allow.to.roles.descriptor";
import { ApiResponse } from "src/misc/api.response.class";
import { RoleCheckedGuard } from "src/misc/role.checker.guard";
import { DepartmentService } from "src/services/department/department.service";

@Controller("api/department")
@Crud({
  model: {
    type: Department,
  },
  params: {
    id: {
      field: "departmentId",
      type: "number",
      primary: true,
    },
  },
  query: {
    join: {
      parentDepartment: {
        eager: true,
      },
      departments: {
        eager: true,
      },
      departmentJobs: {
        eager: true,
      },
      users: {
        eager: true,
      },
    },
  },
})
export class DepartmentController {
  constructor(public service: DepartmentService) {}

  @Get()
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles("administrator", "moderator")
  async getAllDepartments(): Promise<DepartmentDTO[] | ApiResponse>
  {
    return await this.service.getAllDepartments()
  }

  @Post()
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles("administrator", "moderator")
  async createNewDepartment(
    @Body() data: AddNewDepartmentDto
  ): Promise<Department | ApiResponse> {
    return await this.service.createNewDepartment(data);
  }

  @Patch(":id")
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles("administrator", "moderator")
  async editDepartment(
    @Param("id") departmentId: number,
    @Body() data: EditDepartmentDto
  ): Promise<Department | ApiResponse> {
    return await this.service.editDepartment(departmentId, data);
  }

  @Delete(":id")
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles("administrator", "moderator")
  async deleteDepartment(
    @Param("id") departmentId: number
  ): Promise<ApiResponse> {
    return await this.service.deleteDepartment(departmentId);
  }
}
