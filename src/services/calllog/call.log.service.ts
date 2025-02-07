// src/services/CallLog.service.ts
import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { CallLog } from 'src/entities/CallLog';
import { Repository } from 'typeorm';

@Injectable()
export class CallLogService {
  constructor(
    @InjectRepository(CallLog)
    private callLogRepository: Repository<CallLog>,
  ) {}

  // Dodaj log poziva
  async createLog(number: string, status: string): Promise<CallLog> {
    const log = new CallLog();
    log.number = number;
    log.status = status;

    console.log(log)
    return await this.callLogRepository.save(log);
  }
}
