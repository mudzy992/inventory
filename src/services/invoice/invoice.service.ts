import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { PrinterDTO } from 'src/dtos/invoice/printer.dto';
import { Invoices } from 'src/entities/Invoices';
import { PagePrices } from 'src/entities/PagePrices';
import { PrinterOid } from 'src/entities/PrinterOid';
import { Printers } from 'src/entities/Printers';
import { LessThan, Repository } from 'typeorm'

@Injectable()
export class InvoiceService {
  constructor(
    @InjectRepository(Invoices)
    private readonly invoiceRepository: Repository<Invoices>,
    @InjectRepository(PrinterOid)
    private readonly printerOidRepository: Repository<PrinterOid>,
    @InjectRepository(Printers)
    private readonly printersRepository: Repository<Printers>,
    @InjectRepository(PagePrices)
    private readonly pagePricesRepository: Repository<PagePrices>,
  ) {}

  async getAllInvoices(): Promise<Invoices[]> {
    const invoices = await this.invoiceRepository.find();
    return invoices;
  }

  async calculateInvoice(): Promise<any> {
    try {
      // 1. Pronalazi se posljednja faktura koja ima status "plaćeno"
      const lastPaidInvoice = await this.invoiceRepository.findOne({
        where: { status: 'plaćeno' },
        order: { createdAt: 'DESC' }
      });
      const lastPaidInvoiceId = lastPaidInvoice?.invoiceId;

      // 2. Pronalazi se posljednja kreirana faktura koja ima status "izvršenje"
      const lastExecutionInvoice = await this.invoiceRepository.findOne({
        where: { status: 'izvršenje' },
        order: { createdAt: 'DESC' }
      });
      const lastExecutionInvoiceId = lastExecutionInvoice?.invoiceId;

      if (!lastExecutionInvoiceId) {
        throw new Error("No invoice found with status 'izvršenje'.");
      }

      // 3. Pronađi sve printere povezane s trenutnom fakturom
      const printerOids = await this.printerOidRepository.find({
        where: { invoiceId: lastExecutionInvoiceId }
      });

      const printerIds = [...new Set(printerOids.map(oid => oid.printerId))];

      // 4. Dodaj sve nove OID vrijednosti za trenutnu fakturu
      const printerData = await Promise.all(printerIds.map(async (printerId) => {
        const currentOids = await this.printerOidRepository.find({
          where: { printerId, invoiceId: lastExecutionInvoiceId }
        });
        
        const previousOids = await this.printerOidRepository.find({
          where: { printerId, invoiceId: lastPaidInvoiceId }
        });

        const printerInfo = { printerId, newValues: {}, prevValues: {} };

        currentOids.forEach(oid => {
          if ([26, 27, 28, 29].includes(oid.oidId)) {
            printerInfo.newValues[oid.oidId] = parseInt(oid.value, 10) || 0;
          }
        });

        previousOids.forEach(oid => {
          if ([26, 27, 28, 29].includes(oid.oidId)) {
            printerInfo.prevValues[oid.oidId] = parseInt(oid.value, 10) || 0;
          }
        });

        return printerInfo;
      }));

      // 5. Izračunaj razliku između novih i prethodnih OID vrijednosti
      let totalBlackAndWhite = 0;
      let totalColor = 0;
      let totalScan = 0;

      printerData.forEach(printer => {
        const bwCount = (printer.newValues[26] || 0) + (printer.newValues[28] || 0) - (printer.prevValues[26] || 0) - (printer.prevValues[28] || 0);
        const colorCount = (printer.newValues[27] || 0) - (printer.prevValues[27] || 0);
        const scanCount = (printer.newValues[29] || 0) - (printer.prevValues[29] || 0);

        totalBlackAndWhite += bwCount;
        totalColor += colorCount;
        totalScan += scanCount;
      });

      // 6. Upiši sumirane rezultate u fakturu
      lastExecutionInvoice.blackAndWhite = totalBlackAndWhite;
      lastExecutionInvoice.color = totalColor;
      lastExecutionInvoice.scan = totalScan;

      const pagePrices = await this.pagePricesRepository.findOne({where:{pagePricesId: 1}});
      const totalPrintAmount = (totalBlackAndWhite * Number(pagePrices.blackAndWhitePrice)) + (totalColor * Number(pagePrices.colorPrice)) + (totalScan * Number(pagePrices.scanPrice));

      

      const activatedPrinters = await this.printersRepository.find({
        where: { status: 'activated' },
        relations: ['rentalType2'],
      });

      let totalRentPrice = 0;
        for (const printer of activatedPrinters) {
            totalRentPrice += printer.rentalType2.price || 0;
        }
        const totalAmount = totalRentPrice + totalPrintAmount;

        lastExecutionInvoice.rentPrice = totalRentPrice.toString();
        lastExecutionInvoice.totalAmount = totalAmount.toString();
        await this.invoiceRepository.save(lastExecutionInvoice);

      return { message: 'Obračun fakture uspješno izvršen.' };
    } catch (error) {
      console.error("Error calculating invoice: ", error);
      throw new Error("Došlo je do greške prilikom obračuna fakture.");
    }
  }

  async getPrintersForInvoice(invoiceId: number): Promise<PrinterDTO[]> {
    const invoice = await this.invoiceRepository.findOne({
      where: { invoiceId: invoiceId },
      relations: ['printerOs', 'printerOs.printer', 'printerOs.printer.rentalType2'],
    });
  
    if (!invoice) {
      throw new Error('Invoice not found');
    }
  
    const printerMap = new Map<number, PrinterDTO>();
  
    for (const printerOid of invoice.printerOs) {
      const printer = printerOid.printer;
  
      if (printerMap.has(printer.printerId)) continue;
  
      const currentOids = await this.printerOidRepository.find({
        where: { invoice: { invoiceId: invoiceId }, printer: { printerId: printer.printerId } },
      });
  
      const previousInvoice = await this.invoiceRepository.findOne({
        where: {
          createdAt: LessThan(invoice.createdAt),
        },
        order: { createdAt: 'DESC' },
        relations: ['printerOs'],
      });
  
      const previousOids = previousInvoice
        ? await this.printerOidRepository.find({
            where: { invoice: { invoiceId: previousInvoice.invoiceId }, printer: { printerId: printer.printerId } },
          })
        : [];
  
      const dto = new PrinterDTO();
      dto.printerId = printer.printerId;
      dto.userCode = printer.userCode;
      dto.connection = printer.connection;
      dto.printerType = printer.printerType;
      dto.serialNumber = printer.serialNumber;
      dto.activity = printer.activity;
      dto.rentalType = printer.rentalType2.name;
      dto.ownership = printer.ownership;
      dto.status = printer.status;
  
      dto.counters = {
        oid27: this.getCounterData(currentOids, previousOids, 27),
        oid28: this.getCounterData(currentOids, previousOids, 28),
        oid29: this.getCounterData(currentOids, previousOids, 29),
      };
  
      printerMap.set(printer.printerId, dto);
    }
  
    return Array.from(printerMap.values());
  }
  
  private getCounterData(currentOids: PrinterOid[], previousOids: PrinterOid[], oid: number) {
    const current = currentOids.find((o) => Number(o.oidId) === oid);
    const previous = previousOids.find((o) => Number(o.oidId) === oid);
 
    return {
      current: current ? { value: Number(current.value), printerOidId: current.printerOidId } : null,
      previous: previous ? { value: Number(previous.value), printerOidId: previous.printerOidId } : null,
    };
  }
  
}
