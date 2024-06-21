import { Controller, Get, Param, Put, Post, Body, UseGuards } from '@nestjs/common';
import { Crud } from '@nestjsx/crud';
import { PrinterOid } from 'src/entities/PrinterOid';
import { AllowToRoles } from 'src/misc/allow.to.roles.descriptor';
import { RoleCheckedGuard } from 'src/misc/role.checker.guard';
import { SnmpService } from 'src/services/snmp/snmp.service';

@Controller('api/snmp')
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
export class SnmpController {
  constructor(private readonly snmpService: SnmpService) {}

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
}
