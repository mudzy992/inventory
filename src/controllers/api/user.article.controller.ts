import { Controller } from '@nestjs/common';
import { Crud } from '@nestjsx/crud';
import { UserArticle } from 'src/entities/UserArticle';
import { UserArticleService } from 'src/services/userArticle/user.article.service';

@Controller('api/userArticle')
@Crud({
  model: {
    type: UserArticle,
  },
  params: {
    id: {
      field: 'userArticleId',
      type: 'number',
      primary: true,
    },
  },
  query: {
    join: {
      debt: {
        eager: true,
      },
      destroy: {
        eager: true,
      },
      responsibility: {
        eager: true,
      },
      user: {
        eager: true,
      }
    },
  },
})
export class UserArticleController {
  constructor(public service: UserArticleService) {}
}