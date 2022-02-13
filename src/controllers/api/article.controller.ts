import { Body, Controller, Param, Patch, Post } from '@nestjs/common';
import { Crud } from '@nestjsx/crud';
import { AddArticleDto } from 'src/dtos/article/add.article.dto';
import { EditArticleInStockDto } from 'src/dtos/stock/edit.article.in.stock.dto';
import { Article } from 'src/entities/Article';
import { ApiResponse } from 'src/misc/api.response.class';
import { ArticleService } from 'src/services/article/article.service';

@Controller('api/article')
@Crud({
  model: {
    type: Article,
  },
  params: {
    id: {
      field: 'articleId',
      type: 'number',
      primary: true,
    },
  },
  query: {
    join: {
      category: {
        eager: true,
      },
      articleFeature: {
        eager: true,
      },
      features: {
        eager: true,
      },
      userArticles: {
        eager: true,
      },
      userDetails: {
        eager: true,
      },
      articles: {
        eager: true,
      },
      articleStocDestroy: {
        eager: true,
      },
    },
  },
})
export class ArticleController {
  constructor(public service: ArticleService) {}
  @Post()
  async createFullArticle(
    @Body() data: AddArticleDto,
  ): Promise<Article | ApiResponse> {
    const sapnumber = await this.service.getBySapNumber(data.sap_number);
    /* Ako artikal po sap broju već postoji u skladištu, isti ne dodavati ponovo */
    if (sapnumber) {
      /* Implementirati mehanizam, ako artikal postoji promjeniti mu količinu, tj. dodati novu količinu na postojeću */
      return new ApiResponse('error', -1000, 'Artikal već postoji u skladištu');
    }
    return await this.service.createNewArticleInStock(data);
  }

  @Patch(':id')
  async editArticleDataInStock(
    @Param('id') id: number,
    @Body() data: EditArticleInStockDto,
  ) {
    return await this.service.changeArticleAvailableValueInStock(
      id,
      data.valueAvailable,
    );
  }
} /* Kraj koda */
