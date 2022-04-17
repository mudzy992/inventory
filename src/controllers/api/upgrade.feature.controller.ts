import { Body, Controller, Get, Param, Post } from '@nestjs/common';
import { Crud } from '@nestjsx/crud';
import { UpgradeFeatureDto } from 'src/dtos/upgradeFeature/upgrade.feature.dto';
import { UpgradeFeature } from 'src/entities/UpgradeFeature';
import { UpgradeFeatureService } from 'src/services/upgradeFeature/upgrade.features.service';

@Controller('api/upgradeFeature')
@Crud({
  model: {
    type: UpgradeFeature,
  },
  params: {
    id: {
      field: 'upgradeFeatureId',
      type: 'number',
      primary: true,
    },
  },
  query: {
    join: {
      serialNumber2: {
        eager: true,
      },
    },
  },
})
export class UpgradeFeatureController {
  constructor(
    public upgradeFeatureService: UpgradeFeatureService,
  ) {}
  @Post('/add/:sb')
  async doChangeStatus(
    @Body() data: UpgradeFeatureDto,
    @Param('sb') sb: string,
  ) {
    return this.upgradeFeatureService.newUpgradeFeature(sb, data)
  }

  @Get('/get/:sb')
  async getAllUpgrades(
    @Param('sb') sb: string,
  ) {
    return this.upgradeFeatureService.getFeatureBySb(sb)
  }
}
