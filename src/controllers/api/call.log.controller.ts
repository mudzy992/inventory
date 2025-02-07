// src/controllers/CallLog.controller.ts
import { Controller, Post, Body } from '@nestjs/common';
import { CallLogService } from 'src/services/calllog/call.log.service';

@Controller('call-logs')
export class CallLogController {
  constructor(private readonly callLogService: CallLogService) {}

  // Endpoint za prijem obavještenja o pozivu
  @Post()
  async createCallLog(@Body() body: { number: string, status: string }) {
    // U ovoj funkciji možeš procesirati telo XML-a ako je potrebno
    const { number, status } = body;
    await this.callLogService.createLog(number, status);
    return { message: 'Log created' };
  }
}
