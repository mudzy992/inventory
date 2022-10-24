import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { TypeOrmCrudService } from '@nestjsx/crud-typeorm';
import { AddNewDepartmentJobDto } from 'src/dtos/departmentJob/add.new.department.job.dto';
import { DepartmentJob } from 'src/entities/DepartmentJob';
import { ApiResponse } from 'src/misc/api.response.class';
import { Repository } from 'typeorm';

@Injectable()
export class DepartmentJobService extends TypeOrmCrudService<DepartmentJob> {
  constructor(
    @InjectRepository(DepartmentJob)
    private readonly departmentJob: Repository<DepartmentJob>, //Čim spomenenom neki repozitorijum moramo da taj repozitoriju evidentiramo u našem osnovnom modulu (app.module.ts)
  ) {
    super(departmentJob);
  }
  async createNewDepartmentJob(data: AddNewDepartmentJobDto): Promise<DepartmentJob | ApiResponse> {
    const newDepartmentJob: DepartmentJob = new DepartmentJob();
    newDepartmentJob.departmentId = data.departmnetId;
    newDepartmentJob.jobId = data.jobId;;
    newDepartmentJob.locationId = data.locationId;

    const savedDepartmentJob = await this.departmentJob.save(newDepartmentJob);

    if (!savedDepartmentJob) {
      return new ApiResponse('error', -4002, 'Veza sektor, radno mjesto i lokacije nije sačuvana')
    }

    return await this.findOne(savedDepartmentJob.departmentJobId, {
      relations: ['department', 'job', 'location', 'users'],
    })
  }
}
