import { Injectable } from "@nestjs/common";
import { InjectRepository } from "@nestjs/typeorm";
import { TypeOrmCrudService } from "@nestjsx/crud-typeorm";
import { AddNewDepartmentDto } from "src/dtos/department/add.new.department.dto";
import { DepartmentDTO } from "src/dtos/department/department.dto";
import { EditDepartmentDto } from "src/dtos/department/edit.department.dto";
import { Department } from "src/entities/Department";
import { ApiResponse } from "src/misc/api.response.class";
import { Repository } from "typeorm";

@Injectable()
export class DepartmentService extends TypeOrmCrudService<Department> {
  constructor(
    @InjectRepository(Department)
    private readonly department: Repository<Department>
  ) {
    super(department);
  }
  async getAllDepartments(): Promise<DepartmentDTO[] | ApiResponse> {
    const departmentData = await this.department.find()
    const response: DepartmentDTO[] = await departmentData.map((item) => ({
      departmentId: item.departmentId,
      title: item.title,
      description: item.description,
      departmendCode: item.departmendCode,
      parentDepartmentId: item.parentDepartmentId
    }))
    if(response){
      return response
    }
    return new ApiResponse(
      "error",
      -4010,
      "Lista sektora/odjeljena nije prođanena"
    );
  }
  async createNewDepartment(
    data: AddNewDepartmentDto
  ): Promise<Department | ApiResponse> {
    const newDepartment: Department = new Department();
    newDepartment.title = data.title;
    newDepartment.description = data.description;
    newDepartment.departmendCode = data.departmentCode;
    newDepartment.parentDepartmentId = data.parentDepartmentId;

    const savedDepartment = await this.department.save(newDepartment);

    if (!savedDepartment) {
      return new ApiResponse(
        "error",
        -4002,
        "Sektor ili odjeljenje nije sačuvano"
      );
    }

    return await this.findOne({
      where: { departmentId: savedDepartment.departmentId },
      relations: ["parentDepartment", "departments", "departmentJobs"],
    });
  }

  async editDepartment(
    departmentId: number,
    data: EditDepartmentDto
  ): Promise<Department | ApiResponse> {
    const existingDepartmet: Department = await this.department.findOne({
      where: { departmentId: departmentId },
    });
    if (!existingDepartmet) {
      return new ApiResponse(
        "error",
        -4003,
        "Sektor ili odjeljenje nije pronađen/o"
      );
    }

    existingDepartmet.title = data.title;
    existingDepartmet.description = data.description;
    existingDepartmet.departmendCode = data.departmentCode;
    existingDepartmet.parentDepartmentId = data.parentDepartmentId;

    const savedEditedDepartmet = this.department.save(existingDepartmet);

    if (!savedEditedDepartmet) {
      return new ApiResponse(
        "error",
        -4002,
        "Sektor ili odjeljenje  nije sačuvano"
      );
    }

    return savedEditedDepartmet;
  }

  async deleteDepartment(departmentId: number): Promise<ApiResponse> {
    const existingDepartmet: Department = await this.department.findOne({
      where: { departmentId: departmentId },
    });
    if (!existingDepartmet) {
      return new ApiResponse(
        "error",
        -4003,
        "Sektor ili odjeljenje nije pronađen/o"
      );
    }

    if (existingDepartmet.parentDepartmentId !== null) {
      return new ApiResponse(
        "error",
        -4006,
        "Nemoguće obrisati sektor ili odjeljenje koje je dio nekog drugog sektora ili odjeljenja!"
      );
    }
    if (existingDepartmet.parentDepartmentId === null) {
      const existingParentId = await this.department.findOne({
        where: { parentDepartmentId: departmentId },
      });
      if (existingParentId) {
        return new ApiResponse(
          "error",
          -4007,
          "Nemoguće obrisati glavni sektor ili odjeljenje, potrebno obrisati sektore ili odjeljenja koja se nalaze u istom!"
        );
      }
    }

    const deleteExistingDepartmet = await this.department.delete(departmentId);
    if (!deleteExistingDepartmet) {
      return new ApiResponse(
        "error",
        -4004,
        "Sektor ili odjeljenje nije obrisano"
      );
    }

    return new ApiResponse(
      "ok",
      -4005,
      "Sektor ili odjeljenje uspješno obrisano"
    );
  }
}
