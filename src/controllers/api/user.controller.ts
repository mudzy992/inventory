import { Controller } from '@nestjs/common';
import { Crud } from '@nestjsx/crud';
import { User } from 'src/entities/User';
import { UserService } from 'src/services/user/article.service';

@Controller('api/user')
@Crud({
  model: {
    type: User,
  },
  params: {
    id: {
      field: 'userId',
      type: 'number',
      primary: true,
    },
  },
  query: {
    join: {
      userArticles: {
        eager: true,
      },
      articles: {
        eager: true,
      },
    },
  },
})
export class UserController {
  constructor(public service: UserService) {}
}
