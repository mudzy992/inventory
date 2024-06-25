import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { In, Repository } from 'typeorm';
import * as snmp from 'net-snmp';
import { Printers } from 'src/entities/Printers';
import { Oids } from 'src/entities/Oids';
import { PrinterOid } from 'src/entities/PrinterOid';
import { Invoices } from 'src/entities/Invoices';
import { ApiResponse } from 'src/misc/api.response.class';

@Injectable()
export class SnmpService {
constructor(
    @InjectRepository(Printers)
    private readonly printerRepository: Repository<Printers>,
    @InjectRepository(Oids)
    private readonly oidRepository: Repository<Oids>,
    @InjectRepository(PrinterOid)
    private readonly printerOidRepository: Repository<PrinterOid>,
    @InjectRepository(Invoices)
    private readonly invoiceRepository: Repository<Invoices>,
    ) {}

    private readonly community = 'public';
    private readonly version = snmp.Version2c;
    private wakeUpOid = '1.3.6.1.2.1.1.7.0';
    private sessionOptions = {
        port: 161,
        retries: 2,
        timeout: 5000,
        transport: 'udp4',
        trapPort: 162,
        backwardsGetNexts: true,
        repotOidMismatchErrors: false,
        idBitsSize: 32,
    };

  

    async getAllPrinterOids(): Promise<PrinterOid[]> {
        return this.printerOidRepository.find({
        relations: ['printer', 'oid'],
        });
    }

    private async getOidValues(printer: Printers, oids: Oids[]): Promise<any> {
        return new Promise((resolve) => {
        const isCanon = printer.printerType.toLowerCase().includes('canon');
        const snmpVersion = isCanon ? snmp.Version1 : snmp.Version2c;
        const session = snmp.createSession(printer.connection, this.community, snmpVersion, this.sessionOptions);
        const results = {};

        const canonSpecificOids: Oids[] = [
            {
            oidId: 0, code: '1.3.6.1.4.1.1602.1.11.1.3.1.4.113', name: 'Total (Black/Small)',
            printerOs: [],
            status: 'activated'
            },
            {
            oidId: 0, code: '1.3.6.1.4.1.1602.1.11.1.3.1.4.501', name: 'Scan (Total 1)',
            printerOs: [],
            status: 'activated'
            },
        ];

        const allOids = isCanon ? oids.concat(canonSpecificOids) : oids;

        let completedRequests = 0;

        function checkAndResolve() {
            if (completedRequests === allOids.length) {
            // Dio gdje se stanja za kolorce prebacuju na jedan oid
            if (
                    parseInt(results['1.3.6.1.4.1.1347.42.3.1.2.1.1.2.1']) > 0 &&
                    parseInt(results['1.3.6.1.4.1.1347.42.3.1.2.1.1.1.1']) > 0
                ) {
                    results['1.3.6.1.4.1.1347.43.10.1.1.12.1.1'] = (
                        parseInt(results['1.3.6.1.4.1.1347.42.3.1.2.1.1.2.1']) +
                        parseInt(results['1.3.6.1.4.1.1347.42.3.1.2.1.1.1.1'])
                    ).toString();
                    results['1.3.6.1.4.1.1347.42.2.1.1.1.7.1.1'] = "0";
                } else {
                    // 6526 ima poseban tretman
                    if(results['1.3.6.1.2.1.43.5.1.1.16.1'].includes('6526')){
                        results['1.3.6.1.4.1.1347.43.10.1.1.12.1.1'] = results['1.3.6.1.4.1.1347.42.2.1.1.1.7.1.1'];
                        results['1.3.6.1.4.1.1347.42.2.1.1.1.7.1.1'] = "0";
                    }
                }
            

            if (results['1.3.6.1.4.1.1347.42.3.1.2.1.1.1.3'] && results['1.3.6.1.4.1.1347.42.3.1.2.1.1.2.3']) {
                results['1.3.6.1.4.1.1347.42.2.1.1.1.8.1.1'] = (
                parseInt(results['1.3.6.1.4.1.1347.42.3.1.2.1.1.1.3']) +
                parseInt(results['1.3.6.1.4.1.1347.42.3.1.2.1.1.2.3'])
                ).toString();
            }

            if (results['1.3.6.1.2.1.43.5.1.1.16.1'] && results['1.3.6.1.2.1.43.5.1.1.16.1'].includes('8124')) {
                results['1.3.6.1.4.1.1347.42.2.1.1.1.8.1.1'] = (
                    parseInt(results['1.3.6.1.4.1.1347.42.3.1.2.1.1.1.2']) +
                    parseInt(results['1.3.6.1.4.1.1347.42.3.1.2.1.1.2.2'])
                ).toString();
            }
            
            // dio gdje kenoni se prebacuju na jedan odi
            if (isCanon) {
                results['1.3.6.1.4.1.1347.43.10.1.1.12.1.1'] = results['1.3.6.1.4.1.1602.1.11.1.3.1.4.113'];
                results['1.3.6.1.4.1.1347.46.10.1.1.5.3'] = results['1.3.6.1.4.1.1602.1.11.1.3.1.4.501'];
            }

            session.close();
            resolve(results);
            }
        }

        function getOid(oid: Oids) {
            session.get([oid.code], (error, varbinds) => {
            if (error) {
                results[oid.code] = '';
            } else {
                results[oid.code] = varbinds[0].value;
            }

            completedRequests++;
            checkAndResolve();
            });
        }

        session.get([this.wakeUpOid], (error, varbinds) => {
            if (!error && varbinds && varbinds[0] && varbinds[0].value !== null) {
            console.log(`Buđenje:${printer.connection} - ${printer.ownership}`);
            }

            allOids.forEach((oid) => getOid(oid));
        });
        });
    }

    private async getPreviousMonthOidValues(printerId: number): Promise<Record<string, string>> {
        const previousInvoice = await this.invoiceRepository.find({
            where:{status: "plaćeno"},
            order: { createdAt: 'DESC' },
            take: 1
        });

        if (!previousInvoice) {
        return {};
        }

        const previousOids = await this.printerOidRepository.find({
        where: {
            printerId: printerId,
            invoiceId: previousInvoice[0].invoiceId,
        },
        relations: ['oid'],
        });

        const previousValues = {};
        previousOids.forEach(po => {
        previousValues[po.oid.code] = po.value;
        });
        return previousValues;
    }

    public async fetchPrinterData(): Promise<any> {
        try {
        const lastInvoice = await this.invoiceRepository.find({ order: { createdAt: "DESC" }, take: 1 });
        if (lastInvoice.length > 0) {
            const firstInvoice = lastInvoice[0];
            if (firstInvoice.status === "izvršenje") {
            const lastInvoiceDate = new Date(firstInvoice.createdAt);
            const currentDate = new Date();
            const differenceInDays = Math.floor((currentDate.getTime() - lastInvoiceDate.getTime()) / (1000 * 3600 * 24));
    
            if (differenceInDays < 5) {
                return new ApiResponse("error", -4004, "Posljednja faktura je u statusu 'izvršenje'. Molimo sačekajte 5 dana prije novog prikupljanja podataka.");
            }
            }
        }
    
        let newInvoice = new Invoices();
        newInvoice.status = "izvršenje";
        newInvoice.createdAt = new Date();
        newInvoice.invoiceNumber = Number(lastInvoice[0].invoiceNumber) + 1;
        newInvoice.type = "Printeri";
        newInvoice = await this.invoiceRepository.save(newInvoice);
    
        const printers = await this.printerRepository.find();
        const oids = await this.oidRepository.find();
        const results = [];
    
        for (const printer of printers) {
            if (printer.status === 'deactivated') {
                continue;
            }
    
                if (printer.connection.includes('USB')) {
                    for (const oid of oids) {
                        if (oid.status === 'activated') {
                            let printerOid = new PrinterOid();
                            printerOid.printerId = printer.printerId;
                            printerOid.oidId = oid.oidId;
                            printerOid.value = ''; 
                            printerOid.invoiceId = newInvoice.invoiceId;
                            await this.printerOidRepository.save(printerOid);
                        }
                    }
                continue;
            }
    
            const oidValues = await this.getOidValues(printer, oids);
            const printerData = { printer: printer.printerType, oids: oidValues };
    
            for (const oid of oids) {
                if(oid.status === 'deactivated') {
                    continue;
                }
                if (oid.status === 'activated') {
                    let printerOid = new PrinterOid();
                    const previousValues = await this.getPreviousMonthOidValues(printer.printerId);
                    printerOid.printerId = printer.printerId;
                    printerOid.oidId = oid.oidId;
                    printerOid.value = oidValues[oid.code] || previousValues[oid.code] || ''; 
                    printerOid.invoiceId = newInvoice.invoiceId;
                    await this.printerOidRepository.save(printerOid);
    
                // Log data fetching
                console.log(`Printer: ${printer.connection}, ${oid.name}: ${printerOid.value}`);
            }
            }
    
            results.push(printerData);
        }
    
        return results;
        } catch (error) {
        console.error("Greška prilikom hvatanja podataka: ", error);
        return new ApiResponse("error", -4001, "Došlo je do greške prilikom prikupljanja podataka.");
        }
    }

    public async updatePrinterData(printerId: number, updateData: any): Promise<any> {
        try {
        const printer = await this.printerRepository.findOne({where: {printerId: printerId}});
        const oids = await this.oidRepository.find();

        if (!printer) {
            throw new Error('Printer nije pronađen');
        }

        for (const oid of oids) {
            const printerOid = await this.printerOidRepository.findOne({where: {printerId: printerId}});
            if (printerOid) {
            printerOid.value = updateData[oid.name] || '';
            await this.printerOidRepository.save(printerOid);
            }
        }

        return new ApiResponse("ok", 0, "Podaci o printeru uspješno izmjenjeni");
        } catch (error) {
        return new ApiResponse("error", -4003, "Greška prilikom izmjene podataka");
        }
    }

    private async getCurrentOidValues(printerId: number): Promise<Record<string, string>> {
        const printer = await this.printerRepository.findOne({ where: { printerId } });
        const oids = await this.oidRepository.find();
        return this.getOidValues(printer, oids);
    }

    private async getPreviousOidValues(printerId: number): Promise<Record<string, string>> {
        return this.getPreviousMonthOidValues(printerId);
    }

    public async syncOidValues(invoiceId: number): Promise<void> {
        const printers = await this.printerRepository.find();
        const oids = await this.oidRepository.find();
    
        for (const printer of printers) {
            if (printer.status === 'deactivated' || printer.connection === "USB") {
                console.log("skip", printer.ownership, printer.connection);
                continue;
            }
    
            const currentOidValues = await this.getCurrentOidValues(printer.printerId);
            const previousOidValues = await this.getPreviousOidValues(printer.printerId);
    
            for (const oid of oids) {
                const currentValue = currentOidValues[oid.code];
                const previousValue = previousOidValues[oid.code];

                // Provjera da li je trenutna vrijednost undefined, prazna ili NaN
                if (currentValue === undefined || currentValue === "" || (typeof currentValue === 'number' && isNaN(currentValue))) {
                    console.log("Skipping undefined or empty value for OID:", oid.code);
                    continue;
                }
    
                // Provjera za numeričke vrijednosti - ažurirati ako je trenutna veća od prethodne
                if (typeof currentValue === 'number' && typeof previousValue === 'number') {
                    if (currentValue > previousValue) {
                        await this.updateOidValues(printer.printerId, oid.oidId, currentValue, invoiceId);
                        console.log("Printer:", printer.connection, "Prev:", previousValue, "New:", currentValue);
                    }
                } else {
                    // Za ostale tipove, samo ažurirajte ako su različiti
                    if (currentValue !== previousValue) {
                        await this.updateOidValues(printer.printerId, oid.oidId, currentValue.toString(), invoiceId);
                        console.log("Printer:", printer.printerId,":", printer.connection, "Prev:", previousValue, "New:", currentValue);
                    }
                }
            }
        }
    }

    private async updateOidValues(printerId: number, oidId: number, value: string, invoiceId: number): Promise<void> {
        const existingPrinterOid = await this.printerOidRepository.findOne({
            where: {
                printerId:printerId,
                oidId:oidId,
                invoiceId:invoiceId
            }
        });
    
        if (existingPrinterOid) {
            existingPrinterOid.value = value;
            await this.printerOidRepository.save(existingPrinterOid);
        } /* else {
            const newPrinterOid = new PrinterOid();
            newPrinterOid.printerId = printerId;
            newPrinterOid.oidId = oid.oidId;
            newPrinterOid.value = value || "";
            newPrinterOid.invoiceId = invoiceId;
            await this.printerOidRepository.save(newPrinterOid);
        } */
    }
}
