import { Body, Controller, Get, Param, Patch, Post, Query } from '@nestjs/common';
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
} 
