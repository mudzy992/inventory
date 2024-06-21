import { Controller, Get, Param, Put, Post, Body, UseGuards, ParseIntPipe } from '@nestjs/common';
import { Crud } from '@nestjsx/crud';
import { PrinterDTO } from 'src/dtos/invoice/printer.dto';
import { Invoices } from 'src/entities/Invoices';
import { AllowToRoles } from 'src/misc/allow.to.roles.descriptor';
import { RoleCheckedGuard } from 'src/misc/role.checker.guard';
import { InvoiceService } from 'src/services/invoice/invoice.service';

@Controller('api/invoice')
@Crud({
  model: {
    type: Invoices,
  },
  params: {
    id: {
      field: 'invoiceId',
      type: 'number',
      primary: true,
    },
  },
  query: {
    join: {
      printerOs: {
        eager: true,
      },
    },
  },
})
export class InvoiceController {
    constructor(private readonly invoiceService: InvoiceService) {}

    @Get()
    @UseGuards(RoleCheckedGuard)
    @AllowToRoles("administrator", "moderator")
    async getAllInvoices() {
      return this.invoiceService.getAllInvoices();
    }

    @Post()
    @UseGuards(RoleCheckedGuard)
    @AllowToRoles('administrator', 'moderator')
    async calculateInvoice() {
      return this.invoiceService.calculateInvoice();
    }

    @Get(":invoiceId/printers")
    @UseGuards(RoleCheckedGuard)
    @AllowToRoles("administrator", "moderator")
    async getAllInvoicePrinters(@Param("invoiceId") invoiceId: number) {
      return this.invoiceService.getPrintersForInvoice(invoiceId);
    }
}
