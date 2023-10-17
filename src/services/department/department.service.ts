import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { TypeOrmCrudService } from '@nestjsx/crud-typeorm';
import { AddNewDepartmentDto } from 'src/dtos/department/add.new.department.dto';
import { EditDepartmentDto } from 'src/dtos/department/edit.department.dto';
import { Department } from 'src/entities/Department';
import { ApiResponse } from 'src/misc/api.response.class';
import { Repository } from 'typeorm';

@Injectable()
export class DepartmentService extends TypeOrmCrudService<Department> {
  constructor(
    @InjectRepository(Department)
    private readonly department: Repository<Department>,
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
      return new ApiResponse('error', -4002, 'Sektor ili odjeljenje nije sačuvano');
    }

    return await this.findOne({
      where: { departmentId: savedDepartment.departmentId },
      relations: ['parentDepartment', 'departments', 'departmentJobs'],
    });
  }

  async editDepartment(departmentId: number, data: EditDepartmentDto): Promise<Department | ApiResponse> {
    const existingDepartment: Department = await this.department.findOne({ where: { departmentId: departmentId } });
    if (!existingDepartment) {
      return new ApiResponse('error', -4003, 'Sektor ili odjeljenje nije pronađeno');
    }

    existingDepartment.title = data.title;
    existingDepartment.description = data.description;
    existingDepartment.departmendCode = data.departmentCode;
    existingDepartment.parentDepartmentId = data.parentDepartmentId;

    const savedEditedDepartment = await this.department.save(existingDepartment);

    if (!savedEditedDepartment) {
      return new ApiResponse('error', -4002, 'Sektor ili odjeljenje nije sačuvano');
    }

    return savedEditedDepartment;
  }

  async deleteDepartment(departmentId: number): Promise<ApiResponse> {
    const existingDepartment: Department = await this.department.findOne({ where: { departmentId: departmentId } });
    if (!existingDepartment) {
      return new ApiResponse('error', -4003, 'Sektor ili odjeljenje nije pronađeno');
    }

    // Check if the department has sub-departments
    const subDepartmentsCount = await this.department.count({ where: { parentDepartmentId: departmentId } });
    if (subDepartmentsCount > 0) {
      return new ApiResponse('error', -4006, 'Nemoguće obrisati sektor ili odjeljenje koje ima podsektore');
    }

    const deleteResult = await this.department.delete(departmentId);

    if (deleteResult.affected === 0) {
      return new ApiResponse('error', -4004, 'Sektor ili odjeljenje nije obrisano');
    }

    return new ApiResponse('ok', 0, 'Sektor ili odjeljenje uspješno obrisano');
  }
}
