import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Article } from 'src/entities/Article';
import { PrinterDTO } from 'src/dtos/invoice/printer.dto';
import { Invoices } from 'src/entities/Invoices';
import { PagePrices } from 'src/entities/PagePrices';
import { PrinterOid } from 'src/entities/PrinterOid';
import { LessThan, Repository } from 'typeorm'

@Injectable()
export class InvoiceService {
  constructor(
    @InjectRepository(Invoices)
    private readonly invoiceRepository: Repository<Invoices>,
    @InjectRepository(PrinterOid)
    private readonly printerOidRepository: Repository<PrinterOid>,
    @InjectRepository(Article)
    private readonly printersRepository: Repository<Article>,
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

      const articleIds = [...new Set(printerOids.map(oid => oid.articleId))];

      // 4. Dodaj sve nove OID vrijednosti za trenutnu fakturu
      const printerData = await Promise.all(articleIds.map(async (articleId) => {
        const currentOids = await this.printerOidRepository.find({
          where: { articleId, invoiceId: lastExecutionInvoiceId }
        });
        
        const previousOids = await this.printerOidRepository.find({
          where: { articleId, invoiceId: lastPaidInvoiceId }
        });

        const printerInfo = { articleId, newValues: {}, prevValues: {} };

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

      

      const activatedPrinters = await this.printersRepository.find(
        {
            relations:["articleFeatures","articleFeatures.feature", "stock"], 
            where:{
                categoryId: 11,
            },
        });

        let totalRentPrice = 0;
        const filteredPrinters = activatedPrinters.filter(printer => 
          printer.articleFeatures.some(af => af.featureValue === "activated")
        );
        for (const printer of filteredPrinters) {
          const featureValues = printer.articleFeatures
              .filter(af => af.feature.featureId === 101) 
              .map(af => parseFloat(af.featureValue) || 0); 
      
          totalRentPrice += featureValues.reduce((acc, val) => acc + val, 0); 
          console.log(totalRentPrice)
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
      relations: ['printerOs', 'printerOs.article.stock', 'printerOs.article.user', 'printerOs.article', 'printerOs.article.articleFeatures', 'printerOs.article.articleFeatures.feature'],
    });
  
    if (!invoice) {
      throw new Error('Invoice not found');
    }
  
    const printerMap = new Map<number, PrinterDTO>();
  
    for (const printerOid of invoice.printerOs) {
      const printer = printerOid.article;
  
      if (printerMap.has(printer.articleId)) continue;
  
      const currentOids = await this.printerOidRepository.find({
        where: { invoice: { invoiceId: invoiceId }, article: { articleId: printer.articleId } },
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
            where: { invoice: { invoiceId: previousInvoice.invoiceId }, article: { articleId: printer.articleId } },
          })
        : [];
  
      const dto = new PrinterDTO();
      dto.printerId = printer.articleId;
      dto.printerType = printer.stock.name;
      dto.serialNumber = printer.serialNumber;
      dto.user = printer.user.fullname;
      dto.printerFeatures = printer.articleFeatures;
  
      dto.counters = {
        oid27: this.getCounterData(currentOids, previousOids, 27),
        oid28: this.getCounterData(currentOids, previousOids, 28),
        oid29: this.getCounterData(currentOids, previousOids, 29),
      };
  
      printerMap.set(printer.articleId, dto);
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
