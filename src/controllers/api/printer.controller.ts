import { Controller, Get, Param, Put, Post, Body, UseGuards } from '@nestjs/common';
import { Crud } from '@nestjsx/crud';
import { PrinterOid } from 'src/entities/PrinterOid';
import { AllowToRoles } from 'src/misc/allow.to.roles.descriptor';
import { RoleCheckedGuard } from 'src/misc/role.checker.guard';
import { PrinterService } from 'src/services/printer.service/printer.service';

@Controller('api/printer')
export class PrinterController {
  constructor(private readonly snmpService: PrinterService) {}

  @Get()
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles('administrator', 'moderator')
  async getAllPrinterOids() {
    return await this.snmpService.getAllPrinterOids();
  }

  @Post()
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles('administrator', 'moderator')
  async fetchPrinterData() {
    return await this.snmpService.fetchPrinterData();
  }

  @Put(':id')
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles('administrator', 'moderator')
  async updatePrinterData(@Param('id') id: number, @Body() updateData: any) {
    return await this.snmpService.updatePrinterData(id, updateData);
  }

  @Put(':invoiceId/update')
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles('administrator', 'moderator')
  async updateInvoiceData(@Param('invoiceId') invoiceId: number) {
    return await this.snmpService.syncOidValues(invoiceId);
  }
}
