import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { TypeOrmCrudService } from '@nestjsx/crud-typeorm';
import { AddNewDepartmentDto } from 'src/dtos/department/add.new.department.dto';
import { Department } from 'src/entities/Department';
import { ApiResponse } from 'src/misc/api.response.class';
import { Repository } from 'typeorm';

@Injectable()
export class DepartmentService extends TypeOrmCrudService<Department> {
  constructor(
    @InjectRepository(Department)
    private readonly department: Repository<Department>, //Čim spomenenom neki repozitorijum moramo da taj repozitoriju evidentiramo u našem osnovnom modulu (app.module.ts)
  ) {
    super(department);
  }
  async createNewDepartment(data: AddNewDepartmentDto): Promise<Department | ApiResponse> {
    const newDepartment: Department = new Department();
    newDepartment.title = data.title;
    newDepartment.description = data.description;
    newDepartment.departmendCode = data.departmentCode;
    newDepartment.parentDepartmentId = data.parentDepartmentId;

    const savedDepartment = await this.department.save(newDepartment);

    if (!savedDepartment) {
      return new ApiResponse('error', -4002, 'Sektor ili odjeljenje nije sačuvano')
    }

    return await this.findOne(savedDepartment.departmentId, {
      relations: ['parentDepartment', 'departments', 'departmentJobs'],
    })
  }
}
