import { Body, Controller, Post, UseGuards } from "@nestjs/common";
import { Crud } from "@nestjsx/crud";
import { AddNewCategoryDto } from "src/dtos/category/add.new.category.dto";
import { Category } from "src/entities/Category";
import { AllowToRoles } from "src/misc/allow.to.roles.descriptor";
import { ApiResponse } from "src/misc/api.response.class";
import { RoleCheckedGuard } from "src/misc/role.checker.guard";
import { CategoryService } from "src/services/category/category.service";

@Controller("api/category")
@Crud({
  model: {
    type: Category,
  },
  params: {
    id: {
      field: "categoryId",
      type: "number",
      primary: true,
    },
  },
  query: {
    join: {
      stocks: {
        eager: true,
      },
      parentCategory: {
        eager: true,
      },
      categories: {
        eager: true,
      },
      features: {
        eager: false,
      },
      articles: {
        eager: false,
      },
    },
  },
})
export class CategoryController {
  constructor(public service: CategoryService) {}
  @Post()
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles("administrator", "moderator")
  async createNewCategory(
    @Body() data: AddNewCategoryDto
  ): Promise<Category | ApiResponse> {
    return await this.service.createNewCategory(data);
  }
}
