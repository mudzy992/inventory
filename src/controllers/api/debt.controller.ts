import { Body, Controller, Param, Post } from '@nestjs/common';
import { Crud } from '@nestjsx/crud';
import { AddEmployeArticleDto } from 'src/dtos/user/add.employe.article.dto';
import { DebtItems } from 'src/entities/DebtItems';
import { DebtItemsService } from 'src/services/debtItems/debt.items.service';

@Controller('api/debt')
@Crud({
  model: {
    type: DebtItems,
  },
  params: {
    id: {
      field: 'debtItemsId',
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
    },
  },
})
export class DebtItemsController {
  constructor(public service: DebtItemsService) {}
  @Post('/add/:id')
  async addArticleToUser(
    @Param('id') id: number,
    @Body() data: AddEmployeArticleDto,
  ) {
    return await this.service.addArticleToEmploye(id, data);
  }
}