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
      article: {
        eager: true,
      },
    },
  },
})
export class UpgradeFeatureController {
  constructor(
    public service: UpgradeFeatureService,
  ) {}
  @Post('/add/:sb')
  async doChangeStatus(
    @Body() data: UpgradeFeatureDto,
    @Param('sb') sb: string,
  ) {
    return this.service.newUpgradeFeature(sb, data)
  }
}
