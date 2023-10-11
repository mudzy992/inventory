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
    private readonly departmentJob: Repository<DepartmentJob>,
  ) {
    super(departmentJob);
  }
  async createNewDepartmentJob(data: AddNewDepartmentJobDto): Promise<DepartmentJob | ApiResponse> {
    
    const newDepartmentJob: DepartmentJob = new DepartmentJob();
    newDepartmentJob.departmentId = data.departmentId;
    newDepartmentJob.jobId = data.jobId;
    newDepartmentJob.locationId = data.locationId;

    const savedDepartmentJob = await this.departmentJob.save(newDepartmentJob);

    if (!savedDepartmentJob) {
      return new ApiResponse('error', -12002, 'Veza sektor, radno mjesto i lokacije nije sačuvana')
    }

    return await this.findOne({
      where: {departmentJobId: savedDepartmentJob.departmentJobId},
      relations: ['department', 'job', 'location'],
    })
  }
}
