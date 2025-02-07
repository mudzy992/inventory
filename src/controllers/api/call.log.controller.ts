// src/controllers/CallLog.controller.ts
import { Controller, Post, Body, Headers } from '@nestjs/common';
import { CallLogService } from 'src/services/calllog/call.log.service';
import * as xml2js from 'xml2js';

@Controller('call-logs')
export class CallLogController {
  constructor(private readonly callLogService: CallLogService) {}

  // Endpoint za prijem obavještenja o pozivu
  @Post()
  async createCallLog(@Body() body: any, @Headers('content-type') contentType: string) {
    let parsedBody;

    // Ako je sadržaj XML, parsiraj ga u JSON
    if (contentType.includes('application/xml')) {
      parsedBody = await this.parseXmlToJson(body);
    } else {
      parsedBody = body;
    }

    const { number, status } = parsedBody;
    await this.callLogService.createLog(number, status);
    return { message: 'Log created' };
  }

  private async parseXmlToJson(xml: string) {
    const parser = new xml2js.Parser();
    return new Promise<any>((resolve, reject) => {
      parser.parseString(xml, (err, result) => {
        if (err) {
          reject(err);
        } else {
          resolve(result.call_log);  // Prilagoditi ovo prema strukturi XML-a
        }
      });
    });
  }
}
