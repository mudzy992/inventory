import { Controller } from '@nestjs/common';
import { Crud } from '@nestjsx/crud';
import { Destroyed } from 'src/entities/Destroyed';
import { DestroyedArticlesService } from 'src/services/destroyedArticles/destroyed.articles.service';

@Controller('api/destroyedArticles')
@Crud({
  model: {
    type: Destroyed,
  },
  params: {
    id: {
      field: 'destroyedId',
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
      },
    },
  },
})
export class DestroyedArticlesController {
  constructor(public service: DestroyedArticlesService) {}
}