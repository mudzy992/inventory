import { Body, Controller, Get, Param, Patch, Post } from '@nestjs/common';
import { Crud } from '@nestjsx/crud';
import { Feature } from 'src/entities/Feature';
import { FeatureService } from 'src/services/feature/feature.service';
import { AddNewFeatureDto } from 'src/dtos/features/add.new.feature.dto';
import { ApiResponse } from 'src/misc/api.response.class';
import { EditFeatureDto } from 'src/dtos/features/edit.feature.dto';

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
      stockFeatures: {
        eager: true,
      },
      category: {
        eager: true,
      },
      articles: {
        eager: false,
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

  @Patch()
  async editFeatures(
    @Body() data: EditFeatureDto,
  ): Promise<Feature | ApiResponse> {
    return await this.service.editFeatures(data)
  }

  @Get('cat/:catId')
  async getByCategoryId(
    @Param('catId') catId: number,
  ) {
    return this.service.getByCategoryId(catId);
  }
}
