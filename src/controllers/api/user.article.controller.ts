import { Body, Controller, Param, Post } from '@nestjs/common';
import { Crud } from '@nestjsx/crud';
import { AddEmployeArticleDto } from 'src/dtos/user/add.employe.article.dto';
import { UserArticle } from 'src/entities/UserArticle';
import { DebtItemsService } from 'src/services/debtItems/debt.items.service';
import { DestroyedArticlesService } from 'src/services/destroyed/destroyed.articles.service';
import { ResponsibilityService } from 'src/services/responsibility/responsibility.service';
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
      debtItems: {
        eager: true,
      },
      destroyeds: {
        eager: true,
      },
      responsibilities: {
        eager: true,
      },
      user: {
        eager: true,
        exclude:['passwordHash']
      },
      article: {
        eager: true,
      },
      document: {
        eager: true,
      },
    },
  },
})
export class UserArticleController {
  constructor(
    public debtItemsService: DebtItemsService,
    public responsibilityItemsService: ResponsibilityService,
    public destroyedItemsService: DestroyedArticlesService,
    public service: UserArticleService,
  ) {}
  @Post('/add/:id')
  async doChangeStatus(
    @Body() data: AddEmployeArticleDto,
    @Param('id') id: number,
  ) {
    if (data.status === 'zaduženo') {
      return this.responsibilityItemsService.addArticleToEmploye(id, data);
    }
    if (data.status === 'razduženo') {
      return this.debtItemsService.addArticleToEmploye(id, data);
    }
    if (data.status === 'otpisano') {
      return this.destroyedItemsService.addArticleToEmploye(id, data);
    }
  }
}
