import { Controller, Get, Param, Put, Post, Body, UseGuards, ParseIntPipe, Patch } from '@nestjs/common';
import { Crud } from '@nestjsx/crud';
import { PrinterDTO } from 'src/dtos/invoice/printer.dto';
import { UpdateInvoiceDto } from 'src/dtos/invoice/update.invoice.dto';
import { Invoices } from 'src/entities/Invoices';
import { AllowToRoles } from 'src/misc/allow.to.roles.descriptor';
import { ApiResponse } from 'src/misc/api.response.class';
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
    async getAllInvoices(
      
    ) {
      return this.invoiceService.getAllInvoices();
    }

    @Get(':invoiceId')
    @UseGuards(RoleCheckedGuard)
    @AllowToRoles("administrator", "moderator")
    async getOneInvoice(@Param('invoiceId') invoiceId: number,) {
      return this.invoiceService.getOneInvoice(invoiceId);
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

    @Patch(':invoiceId')
    @UseGuards(RoleCheckedGuard)
    @AllowToRoles('administrator', 'moderator')
    async updateInvoice(
      @Param('invoiceId') invoiceId: number,
      @Body() updateInvoiceDto: UpdateInvoiceDto
    ): Promise<Invoices | ApiResponse> {
      return this.invoiceService.updateInvoice(invoiceId, updateInvoiceDto)
    }
}
