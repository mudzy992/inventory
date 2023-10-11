import { Body, Controller, Post } from '@nestjs/common';
import { Crud } from '@nestjsx/crud';
import { AddNewCategoryDto } from 'src/dtos/category/add.new.category.dto';
import { Category } from 'src/entities/Category';
import { ApiResponse } from 'src/misc/api.response.class';
import { CategoryService } from 'src/services/category/category.service';

@Controller('api/category')
@Crud({
  model: {
    type: Category,
  },
  params: {
    id: {
      field: 'categoryId',
      type: 'number',
      primary: true,
    },
  },
  query: {
    join: {
      articles: {
        eager: true,
      },
      parentCategory: {
        eager: true,
      },
      categories: {
        eager: true,
      },
      features: {
        eager: true,
      },
    },
  },
})
export class CategoryController {
  constructor(public service: CategoryService) {}
  @Post()
  async createNewCategory(
    @Body() data: AddNewCategoryDto,
  ): Promise <Category | ApiResponse> {
    return await this.service.createNewCategory(data);
  }
}