import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { TypeOrmCrudService } from '@nestjsx/crud-typeorm';
import { AddNewJobDto } from 'src/dtos/job/add.new.job.dto';
import { EditJobDto } from 'src/dtos/job/edit.job.dto';
import { DepartmentJob } from 'src/entities/DepartmentJob';
import { Job } from 'src/entities/Job';
import { ApiResponse } from 'src/misc/api.response.class';
import { Repository } from 'typeorm';

@Injectable()
export class JobService extends TypeOrmCrudService<Job> {
  constructor(
    @InjectRepository(Job)
    private readonly job: Repository<Job>,
    @InjectRepository(DepartmentJob)
    private readonly departmentJob: Repository<DepartmentJob>,
  ) {
    super(job);
  }

  async createNewJob(data: AddNewJobDto): Promise<Job | ApiResponse> {
    try {
      const newJob: Job = new Job();
      newJob.title = data.title;
      newJob.description = data.description;
      newJob.jobCode = data.jobCode;

      const savedJob = await this.job.save(newJob);

      if (!savedJob) {
        return new ApiResponse('error', -10001, 'Radno mjesto nije sačuvano');
      }

      return await this.findOne({
        where: { jobId: savedJob.jobId },
        relations: ['departmentJobs'],
      });
    } catch (error) {
      return new ApiResponse('error', -10000, 'Neuspješno stvaranje radnog mjesta - ' + error);
    }
  }

  async editJob(jobId: number, data: EditJobDto): Promise<Job | ApiResponse> {
    try {
      const existingJob: Job = await this.job.findOne({ where: { jobId } });

      if (!existingJob) {
        return new ApiResponse('error', -10002, 'Radno mjesto nije pronađeno');
      }

      existingJob.title = data.title;
      existingJob.description = data.description;
      existingJob.jobCode = data.jobCode;

      const updatedJob = await this.job.save(existingJob);

      if (!updatedJob) {
        return new ApiResponse('error', -10001, 'Radno mjesto nije sačuvano');
      }

      return await this.findOne({
        where: { jobId: updatedJob.jobId },
        relations: ['departmentJobs'],
      });
    } catch (error) {
      return new ApiResponse('error', -10000, 'Neuspješna izmjena radnog mjesta - ' + error);
    }
  }

  async deleteJob(jobId: number): Promise<ApiResponse> {
    try {
      const existingJob: Job = await this.job.findOne({ where: { jobId } });

      if (!existingJob) {
        return new ApiResponse('error', -10002, 'Radno mjesto nije pronađeno');
      }

      const deleteDepartmentJob = await this.departmentJob.delete({ jobId });

      if (!deleteDepartmentJob) {
        return new ApiResponse('error', -12003, 'Veze radnog mjesta sa sektorom ili odjeljenjem te lokacijom nisu obrisane');
      }

      const deleteJob = await this.job.delete(jobId);

      if (!deleteJob) {
        return new ApiResponse('error', -10003, 'Radno mjesto nije obrisano');
      }

      return new ApiResponse('ok', -10004, 'Radno mjesto kao i sve veze istog sa sektorom ili odjeljenjem te lokacijom uspješno obrisano');
    } catch (error) {
      return new ApiResponse('error', -10000, 'Neuspješno brisanje radnog mjesta - ' + error);
    }
  }
}
