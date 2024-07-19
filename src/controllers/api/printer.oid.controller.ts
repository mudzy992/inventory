import { Controller, Get, Post, Put, Param, Body, UseGuards, Delete } from '@nestjs/common';
import { Crud } from '@nestjsx/crud';
import { PrinterOid } from 'src/entities/PrinterOid';
import { AllowToRoles } from 'src/misc/allow.to.roles.descriptor';
import { RoleCheckedGuard } from 'src/misc/role.checker.guard';
import { PrinterOidService } from 'src/services/printerOid/printer.oid.service';

@Controller('api/printer-oid')
@Crud({
  model: {
    type: PrinterOid,
  },
  params: {
    id: {
      field: 'printerOidId',
      type: 'number',
      primary: true,
    },
  },
  query: {
    join: {
      printer: {
        eager: true,
      },
      oid: {
        eager: true,
      },
    },
  },
})
export class PrinterOidController {
  constructor(private readonly printerOidService: PrinterOidService) {}
  @Post()
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles('administrator', 'moderator')
  async createPrinterOid(@Body() printerOidData: Partial<PrinterOid>) {
    return await this.printerOidService.createPrinterOid(printerOidData);
  }

  @Put(':id')
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles('administrator', 'moderator')
  async editPrinterOid(@Param('id') id: number, @Body() printerOidData: Partial<PrinterOid>) {
    return await this.printerOidService.editPrinterOid(id, printerOidData);
  }

  @Delete(':id')
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles('administrator', 'moderator')
  async deletePrinterOid(@Param('id') id: number) {
    return await this.printerOidService.deletePrinterOid(id);
  }
}
