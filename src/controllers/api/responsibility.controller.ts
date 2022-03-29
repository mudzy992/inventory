import { Body, Controller, Param, Post } from '@nestjs/common';
import { Crud } from '@nestjsx/crud';
import { AddEmployeArticleDto } from 'src/dtos/user/add.employe.article.dto';
import { Responsibility } from 'src/entities/Responsibility';
import { ResponsibilityService } from 'src/services/responsibility/responsibility.service';

@Controller('api/responsibility')
@Crud({
  model: {
    type: Responsibility,
  },
  params: {
    id: {
      field: 'responsibilityId',
      type: 'number',
      primary: true,
    },
  },
  query: {
    join: {
      user: {
        eager: true,
      },
      article: {
        eager: true,
      },
      userArticle: {
        eager: true,
      },
      document: {
        eager: true,
      }
    },
  },
})
export class ResponsibilityController {
  constructor(public service: ResponsibilityService) {}
  @Post('/add/:id')
  async addArticleToUser(
    @Param('id') id: number,
    @Body() data: AddEmployeArticleDto,
  ) {
    return await this.service.addArticleToEmploye(id, data);
  }
} /* Kraj koda */
