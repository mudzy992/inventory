import { Body, Controller, Param, Post } from '@nestjs/common';
import { Crud } from '@nestjsx/crud';
import { AddEmployeArticleDto } from 'src/dtos/user/add.employe.article.dto';
import { Destroyed } from 'src/entities/Destroyed';
import { DestroyedArticlesService } from 'src/services/destroyed/destroyed.articles.service';

@Controller('api/destroyed')
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
      userArticle: {
        eager: true,
      },
      user: {
        eager: true,
      },
      document: {
        eager: true,
      }
    },
  },
})
export class DestroyedArticlesController {
  constructor(public service: DestroyedArticlesService) {}
  @Post('/add/:id')
  async addArticleToUser(
    @Param('id') id: number,
    @Body() data: AddEmployeArticleDto,
  ) {
    return await this.service.addArticleToEmploye(id, data);
  }
}