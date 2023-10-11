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
    private readonly feature: Repository<Feature>, //Čim spomenenom neki repozitorijum moramo da taj repozitoriju evidentiramo u našem osnovnom modulu (app.module.ts)
  ) {
    super(feature);
  }

  async createNewFeature(data: AddNewFeatureDto): Promise <Feature | ApiResponse> {
    const newFeature: Feature = new Feature();
    newFeature.name = data.name;
    newFeature.categoryId = data.categoryId;

    const savedFeature = await this.feature.save(newFeature);

    if(!savedFeature) {
      return new ApiResponse('error', -4001, 'Osobina nije sačuvana')
    }

    return await this.findOne({
      where: {featureId: savedFeature.featureId},
      relations: ['articleFeature', 'category', 'articles'],
    })
  }

  async editFeatures(data: EditFeatureDto): Promise<Feature | ApiResponse> {
    const newFeature: Feature = new Feature();


    return await this.findOne( {
      relations: ['articleFeature',' category',]
    })
  }
}