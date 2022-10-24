import { Body, Controller, Post } from '@nestjs/common';
import { Crud } from '@nestjsx/crud';
import { AddNewJobDto } from 'src/dtos/job/add.new.job.dto';
import { Job } from 'src/entities/Job';
import { ApiResponse } from 'src/misc/api.response.class';
import { JobService } from 'src/services/job/job.service';

@Controller('api/job')
@Crud({
  model: {
    type: Job,
  },
  params: {
    id: {
      field: 'jobId',
      type: 'number',
      primary: true,
    },
  },
  query: {
    join: {
      departmentJobs: {
        eager: true,
      },
    },
  },
})
export class JobController {
  constructor(public service: JobService) {}
  @Post()
  async createNewJob(
    @Body() data: AddNewJobDto,
  ): Promise <Job | ApiResponse> {
    return await this.service.createNewJob(data);
  }
}