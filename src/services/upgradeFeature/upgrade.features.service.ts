import { Injectable } from "@nestjs/common";
import { InjectRepository } from "@nestjs/typeorm";
import { TypeOrmCrudService } from "@nestjsx/crud-typeorm";
import { UpgradeFeatureDTO } from "src/dtos/upgradeFeature/upgrade.feature.dto";
import { UpgradeFeature } from "src/entities/UpgradeFeature";
import { ApiResponse } from "src/misc/api.response.class";
import { Repository } from "typeorm";

@Injectable()
export class UpgradeFeatureService extends TypeOrmCrudService<UpgradeFeature> {
  constructor(
    @InjectRepository(UpgradeFeature)
    private readonly upgradeFeature: Repository<UpgradeFeature>
  ) {
    super(upgradeFeature);
  }

  async getFeaturesByArticleSerialNumber(serial:string): Promise<UpgradeFeatureDTO[] | null> {
    const featuresData = await this.upgradeFeature.find({
      where: { serialNumber: serial}
    })

    const response: UpgradeFeatureDTO[] = await featuresData.map((feature) => ({
      comment: feature.comment,
      timestamp: feature.timestamp,
      name: feature.name,
      value: feature.value,
      upgradeFeatureId: feature.upgradeFeatureId
    }))
    if(response){
      return response
    }
    return null
  }

  async newUpgradeFeature(
    serialNumber: string,
    data: UpgradeFeatureDTO
  ): Promise<UpgradeFeature | ApiResponse> {
    const newFeature: UpgradeFeature = new UpgradeFeature();
    newFeature.name = data.name;
    newFeature.value = data.value;
    newFeature.serialNumber = serialNumber;
    newFeature.comment = data.comment;
    newFeature.articleId = data.articleId;

    const savedFeature = await this.upgradeFeature.save(newFeature);

    if (!savedFeature) {
      return new ApiResponse(
        "error",
        -9000,
        "Došlo je do greške, nadogradnja nije sačuvana"
      );
    }
  }

  async deleteUpgradeFeature(
    upgradeFeatureId: number
  ): Promise<UpgradeFeature | ApiResponse> {
    const deletedUpgradeFeature = await this.upgradeFeature.delete(
      upgradeFeatureId
    );
    if (!deletedUpgradeFeature) {
      return new ApiResponse(
        "error",
        -10001,
        "Došlo je do greške prilikom brisanja nadogradnje!"
      );
    }
    return;
  }
}
