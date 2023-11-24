import {  Controller, Get, Param, Query } from '@nestjs/common';
import { Crud } from '@nestjsx/crud';
import { ArticleTimeline } from 'src/entities/ArticleTimeline';
import { ArticleTimelineService } from 'src/services/articleTimeline/article.timeline.service';

@Controller('api/articleTimeline')
@Crud({
  model: {
    type: ArticleTimeline,
  },
  params: {
    id: {
      field: 'articleTimelineId',
      type: 'number',
      primary: true,
    },
  },
  query: {
    join: {
      article: {
        eager: true,
      },
      user: {
        eager: true,
        exclude:['passwordHash']
      },
      document: {
        eager: true,
      },
    },
  },
})
export class ArticleTimelineController {
  constructor(public articleTimelineService: ArticleTimelineService) {}

  @Get(':id')
  async getById(
    @Param('id') id: string,
  ) {
    return this.articleTimelineService.getById(id);
  }

  @Get()
  async getAll(){
    return this.articleTimelineService.getAll();
  }

  @Get('p/:id')
  async findPaginatedArticlesTimeline(
    @Param('id') id: number,
    @Query('perPage') perPage: number = 10,
    @Query('offset') offset: number = 0,
  ) {
    return this.articleTimelineService.findPaginatedArticlesTimeline(id, perPage, offset);
  }
} 
