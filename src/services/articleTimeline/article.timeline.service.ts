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