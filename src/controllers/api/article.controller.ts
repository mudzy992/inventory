import { Body, Controller, Get, Param, Patch, Post, Query } from '@nestjs/common';
import { Crud } from '@nestjsx/crud';
import { AddArticleDto } from 'src/dtos/article/add.article.dto';
import { EditArticleDto } from 'src/dtos/article/edit.full.article.dto';
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
      user: {
        eager: true,
        exclude:['passwordHash']
      },
      stock: {
        eager: true,
      },
      articleFeatures: {
        eager: true,
      },
      articleTimelines: {
        eager: true,
      },
      documents: {
        eager: true,
      },
      upgradeFeatures: {
        eager: false,
      }
    },
  },
  routes: { exclude: ['updateOneBase'] },
})
export class ArticleController {
  constructor(public service: ArticleService) {}
  @Post(':id')
  async addNewArticle(
    @Param('id') id: number,
    @Body() data: AddArticleDto,
  ): Promise<Article | ApiResponse> {
    return await this.service.addNewArticle(id, data);
  }

  @Get('s/:id')
  async articlePaginationByStockId(
    @Param('id') id: number,
    @Query('perPage') perPage: number = 10,
    @Query('page') page: number = 1, // Dodali smo 'page' parametar za broj stranice
  ) {
    const offset = (page - 1) * perPage; // Izračunajte offset na temelju broja stranice
    return this.service.articlePaginationByStockId(id, perPage, offset);
  }


  @Get('search/:id')
  async articleSearchPaginationByStockId(
    @Param('id') id: number,
    @Query('perPage') perPage: number = 10,
    @Query('page') page: number = 1,
    @Query('query') query: string = '',
  ) {
    const offset = (page - 1) * perPage;
    return this.service.articleSearchPaginationByStockId(id, perPage, offset, query);
  }

  // @Patch(':id')
  // async editFullArticleController(
  //   @Param('id') id: number,
  //   @Body() data: EditArticleDto,
  // ) {
  //   return await this.service.editArticle(id, data);
  // }

  // @Patch('/stock/:id')
  // async changeStockExistArticle(
  //   @Param('id') id: number,
  //   @Body() data: AddArticleDto,
  // ) {
  //   return await this.service.changeStockExistArticle(id, data);
  // }

  
} /* Kraj koda */
