import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { TypeOrmCrudService } from '@nestjsx/crud-typeorm';
import { ArticleTimeline } from 'src/entities/ArticleTimeline';
import { ApiResponse } from 'src/misc/api.response.class';
import { Repository } from 'typeorm';

@Injectable()
export class ArticleTimelineService extends TypeOrmCrudService<ArticleTimeline> {
  constructor(
    @InjectRepository(ArticleTimeline)
    private readonly articleTimelineRepository: Repository<ArticleTimeline>, //Čim spomenenom neki repozitorijum moramo da taj repozitoriju evidentiramo u našem osnovnom modulu (app.module.ts)
  ) {
    super(articleTimelineRepository);
  }

  async getById(id) {
    return await this.articleTimelineRepository.findOne(
      {
        where: {articleTimelineId: id}, 
        relations:['article', 'user', 'document']
      }
      );
  }

  async getAll(){
    return await this.articleTimelineRepository.find(
      {
        relations:['article', 'user', 'document']
      }
    )
  }
}