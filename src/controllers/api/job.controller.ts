import { Body, Controller, Delete, Get, Param, Patch, Post, UseGuards } from "@nestjs/common";
import { Crud } from "@nestjsx/crud";
import { AddNewJobDto } from "src/dtos/job/add.new.job.dto";
import { EditJobDto } from "src/dtos/job/edit.job.dto";
import { JobDTO } from "src/dtos/job/job.dto";
import { Job } from "src/entities/Job";
import { AllowToRoles } from "src/misc/allow.to.roles.descriptor";
import { ApiResponse } from "src/misc/api.response.class";
import { RoleCheckedGuard } from "src/misc/role.checker.guard";
import { JobService } from "src/services/job/job.service";

@Controller("api/job")
@Crud({
  model: {
    type: Job,
  },
  params: {
    id: {
      field: "jobId",
      type: "number",
      primary: true,
    },
  },
  query: {
    join: {
      departmentJobs: {
        eager: true,
      },
      users: {
        eager: false,
      },
    },
  },
})
export class JobController {
  constructor(public service: JobService) {}
  @Get()
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles('administrator', 'moderator', 'user')
  async getAllJobs(): Promise<JobDTO[] | ApiResponse> {
    return this.service.getAllJobs()
  }

  @Get("department/:id")
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles('administrator', 'moderator', 'user')
  async getJobsByDepartmentId(
    @Param('id') departmentId: number
  ): Promise<JobDTO[] | ApiResponse> {
    return this.service.getJobsByDepartmentId(departmentId)
  }
  
  @Post()
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles("administrator", "moderator")
  async createNewJob(@Body() data: AddNewJobDto): Promise<Job | ApiResponse> {
    return await this.service.createNewJob(data);
  }

  @Patch(":id")
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles("administrator", "moderator")
  async editJob(
    @Param("id") id: number,
    @Body() data: EditJobDto
  ): Promise<Job | ApiResponse> {
    return await this.service.editJob(id, data);
  }

  @Delete(":id")
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles("administrator", "moderator")
  async deleteJob(@Param("id") id: number): Promise<ApiResponse> {
    return await this.service.deleteJob(id);
  }
}
