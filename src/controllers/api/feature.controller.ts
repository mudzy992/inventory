import { Body, Controller, Post } from '@nestjs/common';
import { Crud } from '@nestjsx/crud';
import { Feature } from 'src/entities/Feature';
import { FeatureService } from 'src/services/feature/feature.service';
import { AddNewFeatureDto } from 'src/dtos/features/add.new.feature.dto';
import { ApiResponse } from 'src/misc/api.response.class';

@Controller('api/feature')
@Crud({
  model: {
    type: Feature,
  },
  params: {
    id: {
      field: 'featureId',
      type: 'number',
      primary: true,
    },
  },
  query: {
    join: {
      articleFeature: {
        eager: true,
      },
      category: {
        eager: true,
      },
      articles: {
        eager: true,
      },
    },
  },
})
export class FeatureController {
  constructor(public service: FeatureService) {}
  @Post()
  async createNewFeature(
    @Body() data: AddNewFeatureDto,
  ): Promise<Feature | ApiResponse> {
    return await this.service.createNewFeature(data);
  }
}
