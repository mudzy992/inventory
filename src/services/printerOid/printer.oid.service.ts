import { Injectable } from "@nestjs/common";
import { InjectRepository } from "@nestjs/typeorm";
import { TypeOrmCrudService } from "@nestjsx/crud-typeorm";
import { UpgradeFeatureDTO } from "src/dtos/upgradeFeature/upgrade.feature.dto";
import { PrinterOid } from "src/entities/PrinterOid";
import { UpgradeFeature } from "src/entities/UpgradeFeature";
import { ApiResponse } from "src/misc/api.response.class";
import { Repository } from "typeorm";

@Injectable()
export class PrinterOidService extends TypeOrmCrudService<PrinterOid> {
  constructor(
    @InjectRepository(PrinterOid)
    private readonly printerOid: Repository<PrinterOid>
  ) {
    super(printerOid);
  }

  async createPrinterOid(printerOidData: Partial<PrinterOid>) {
    const newPrinterOid = this.printerOid.create(printerOidData);
    return await this.printerOid.save(newPrinterOid);
  }

  async editPrinterOid(printerOidId: number, printerOidData: Partial<PrinterOid>) {
    await this.printerOid.update(printerOidId, printerOidData);
    return await this.printerOid.findOne({where: {printerOidId: printerOidId}});
  }

  async getPrinterOidById(printerOidId: number) {
    return await this.printerOid.findOne({where: {printerOidId: printerOidId}});
  }

  async deletePrinterOid(printerOidId: number) {
    const printerOidToRemove = await this.printerOid.findOne({where: {printerOidId: printerOidId}});
    if (!printerOidToRemove) {
      throw new Error("PrinterOid not found");
    }
    return await this.printerOid.remove(printerOidToRemove);
  }
}
