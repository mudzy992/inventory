import { Controller } from '@nestjs/common';
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
      document: {
        eager: true,
      },
      user: {
        eager: true,
      },
    },
  },
})
export class ArticleTimelineController {
  constructor(public service: ArticleTimelineService) {}
} 
