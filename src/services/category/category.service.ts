import { Injectable } from "@nestjs/common";
import { InjectRepository } from "@nestjs/typeorm";
import { TypeOrmCrudService } from "@nestjsx/crud-typeorm";
import { AddNewCategoryDto } from "src/dtos/category/add.new.category.dto";
import { CategoryDTO } from "src/dtos/category/category.dto";
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

  async getAllCategories(): Promise<CategoryDTO[] | ApiResponse> {
    const categoriesData = await this.category.find({relations: ['categories']})
    const response: CategoryDTO[] = categoriesData.map((item) => ({
      categoryId: item.categoryId,
      name: item.name,
      imagePath: item.imagePath,
      parentCategoryId: item.parentCategoryId || null,
      categories: (item.categories || []).map((parent) => ({
        categoryId: parent.categoryId,
        name: parent.name,
        imagePath: parent.imagePath,
        parentCategoryId: parent.parentCategoryId
      }))
    }))

    if(response){
      return response
    }
    return new ApiResponse("error", -4003, "Lista kategorija nije pronađena");
  }

  async getCategoryById(id:number): Promise<CategoryDTO | ApiResponse> {
    const categoriesData = await this.category.findOne({where: {categoryId: id}, relations: ['categories', 'stocks']})

    const response: CategoryDTO = {
      categoryId: categoriesData.categoryId,
      name: categoriesData.name,
      imagePath: categoriesData.imagePath,
      parentCategoryId: categoriesData.parentCategoryId,
      categories: (categoriesData.categories || []).map((parent) => ({
        categoryId: parent.categoryId,
        name: parent.name,
        imagePath: parent.imagePath,
        parentCategoryId: parent.parentCategoryId
      })),
      stocks: categoriesData.stocks
    }
    if(response){
      return response
    }
    return new ApiResponse("error", -4004, "Kategorija nije pronađena");
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
