import { Body, Controller, Post } from '@nestjs/common';
import { Crud } from '@nestjsx/crud';
import { AddNewDepartmentDto } from 'src/dtos/department/add.new.department.dto';
import { Department } from 'src/entities/Department';
import { ApiResponse } from 'src/misc/api.response.class';
import { DepartmentService } from 'src/services/department/department.service';

@Controller('api/department')
@Crud({
  model: {
    type: Department,
  },
  params: {
    id: {
      field: 'departmentId',
      type: 'number',
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
    },
  },
})
export class DepartmentController {
  constructor(public service: DepartmentService) {}
  @Post()
  async createNewDepartment(
    @Body() data: AddNewDepartmentDto,
  ): Promise <Department | ApiResponse> {
    return await this.service.createNewDepartment(data);
  }
}