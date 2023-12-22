import { Injectable } from "@nestjs/common";
import { InjectRepository } from "@nestjs/typeorm";
import { TypeOrmCrudService } from "@nestjsx/crud-typeorm";
import { AddNewCategoryDto } from "src/dtos/category/add.new.category.dto";
import { Category } from "src/entities/Category";
import { ApiResponse } from "src/misc/api.response.class";
import { Repository } from "typeorm";

@Injectable()
export class CategoryService extends TypeOrmCrudService<Category> {
  constructor(
    @InjectRepository(Category)
    private readonly category: Repository<Category> //Čim spomenenom neki repozitorijum moramo da taj repozitoriju evidentiramo u našem osnovnom modulu (app.module.ts)
  ) {
    super(category);
  }
  async createNewCategory(
    data: AddNewCategoryDto
  ): Promise<Category | ApiResponse> {
    const newCategory: Category = new Category();
    newCategory.name = data.name;
    newCategory.imagePath = data.imagePath;
    newCategory.parentCategoryId = data.parentCategoryId;

    const savedCategory = await this.category.save(newCategory);

    if (!savedCategory) {
      return new ApiResponse("error", -4002, "Kategorija nije sačuvana");
    }

    return await this.findOne({
      where: { categoryId: savedCategory.categoryId },
      relations: ["parentCategory", "categories", "features", "articles"],
    });
  }
}
