import { Body, Controller, Param, Post } from '@nestjs/common';
import { Crud } from '@nestjsx/crud';
import { AddEmployeArticleDto } from 'src/dtos/user/add.employe.article.dto';
import { UserArticle } from 'src/entities/UserArticle';
import { UserArticleService } from 'src/services/userArticle/user.article.service';

@Controller('api/userArticle')
@Crud({
  model: {
    type: UserArticle,
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
      article: {
        eager: true,
      },
      user: {
        eager: true,
      },
    },
  },
})
export class UserArticleController {
  constructor(public service: UserArticleService) {}
  @Post('/add/:id')
  async addArticleToUser(
    @Param('id') id: number,
    @Body() data: AddEmployeArticleDto,
  ) {
    return await this.service.addArticleToEmploye(id, data);
  }
} /* Kraj koda */
