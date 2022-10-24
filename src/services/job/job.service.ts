import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { TypeOrmCrudService } from '@nestjsx/crud-typeorm';
import { AddNewJobDto } from 'src/dtos/job/add.new.job.dto';
import { Job } from 'src/entities/Job';
import { ApiResponse } from 'src/misc/api.response.class';
import { Repository } from 'typeorm';

@Injectable()
export class JobService extends TypeOrmCrudService<Job> {
  constructor(
    @InjectRepository(Job)
    private readonly job: Repository<Job>, //Čim spomenenom neki repozitorijum moramo da taj repozitoriju evidentiramo u našem osnovnom modulu (app.module.ts)
  ) {
    super(job);
  }
  async createNewJob(data: AddNewJobDto): Promise<Job | ApiResponse> {
    const newJob: Job = new Job();
    newJob.title = data.title;
    newJob.description = data.description;
    newJob.jobCode = data.jobCode;

    const savedJob = await this.job.save(newJob);

    if (!savedJob) {
      return new ApiResponse('error', -4002, 'Radno mjesto nije sačuvano')
    }

    return await this.findOne(savedJob.jobId, {
      relations: ['departmentJobs'],
    })
  }
}
