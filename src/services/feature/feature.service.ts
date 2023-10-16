import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { TypeOrmCrudService } from '@nestjsx/crud-typeorm';
import { AddNewFeatureDto } from 'src/dtos/features/add.new.feature.dto';
import { EditFeatureDto } from 'src/dtos/features/edit.feature.dto';
import { Feature } from 'src/entities/Feature';
import { ApiResponse } from 'src/misc/api.response.class';
import { Repository } from 'typeorm';

@Injectable()
export class FeatureService extends TypeOrmCrudService<Feature> {
  constructor(
    @InjectRepository(Feature)
    private readonly feature: Repository<Feature>,
  ) {
    super(feature);
  }

  async createNewFeature(data: AddNewFeatureDto): Promise<Feature | ApiResponse> {
    try {
      const newFeature: Feature = new Feature();
      newFeature.name = data.name;
      newFeature.categoryId = data.categoryId;

      const savedFeature = await this.feature.save(newFeature);

      if (!savedFeature) {
        return new ApiResponse('error', -4001, 'Osobina nije sačuvana');
      }

      return await this.findOne({
        where: { featureId: savedFeature.featureId },
        relations: ['articleFeature', 'category', 'articles'],
      });
    } catch (error) {
      return new ApiResponse('error', -4000, 'Neuspješno stvaranje osobine! -' + error);
    }
  }

  async editFeature(featureId: number, data: EditFeatureDto): Promise<Feature | ApiResponse> {
    try {
      const existingFeature: Feature = await this.feature.findOne({ where: { featureId } });

      if (!existingFeature) {
        return new ApiResponse('error', -4003, 'Osobina nije pronađena');
      }

      existingFeature.name = data.name;
      existingFeature.categoryId = data.categoryId;

      const updatedFeature = await this.feature.save(existingFeature);

      if (!updatedFeature) {
        return new ApiResponse('error', -4002, 'Osobina nije sačuvana');
      }

      return updatedFeature;
    } catch (error) {
      return new ApiResponse('error', -4000, 'Neuspješna izmjena osobine - ' + error);
    }
  }

}
