import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { TypeOrmCrudService } from '@nestjsx/crud-typeorm';
import { ArticleTimeline } from 'src/entities/ArticleTimeline';
import { Repository } from 'typeorm';

@Injectable()
export class ArticleTimelineService extends TypeOrmCrudService<ArticleTimeline> {
  constructor(
    @InjectRepository(ArticleTimeline)
    private readonly articleTimelineRepository: Repository<ArticleTimeline>, //Čim spomenenom neki repozitorijum moramo da taj repozitoriju evidentiramo u našem osnovnom modulu (app.module.ts)
  ) {
    super(articleTimelineRepository);
  }
  /* async getAll() {
    return this.articleTimelineRepository.find(); 
  } */

  async getBySerialNumber(serialNumber: string): Promise<ArticleTimeline[] | null> {
    const serialnumber = await this.articleTimelineRepository.find(
      {
        where:{ serialNumber: serialNumber }
      });
    if (serialnumber) {
      return serialnumber;
    }
    return null;
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

  async findPaginatedArticlesTimeline(id: number, perPage: number, offset: number) {
    const [results, totalResults] = await this.articleTimelineRepository.findAndCount({
      where: { articleId: id },
      take: perPage,
      skip: offset,
      relations: ['article', 'document', 'user'],
    });
  
    return {
      results,
      total: totalResults,
    };
  } 
}