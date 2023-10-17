import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { TypeOrmCrudService } from '@nestjsx/crud-typeorm';
import { AddNewCategoryDto } from 'src/dtos/category/add.new.category.dto';
import { EditCategoryDto } from 'src/dtos/category/edit.category.dto';
import { Category } from 'src/entities/Category';
import { ApiResponse } from 'src/misc/api.response.class';
import { Repository } from 'typeorm';

@Injectable()
export class CategoryService extends TypeOrmCrudService<Category> {
  constructor(
    @InjectRepository(Category)
    private readonly category: Repository<Category>,
  ) {
    super(category);
  }

  async createNewCategory(data: AddNewCategoryDto): Promise<Category | ApiResponse> {
    const newCategory: Category = new Category();
    newCategory.name = data.name;
    newCategory.imagePath = data.imagePath;
    newCategory.parentCategoryId = data.parentCategoryId;

    const savedCategory = await this.category.save(newCategory);

    if (!savedCategory) {
      return new ApiResponse('error', -4002, 'Kategorija nije sačuvana');
    }

    return await this.findOne({
      where: { categoryId: savedCategory.categoryId },
      relations: ['articles', 'parentCategory', 'categories', 'features'],
    });
  }

  async updateCategory(categoryId: number, data: EditCategoryDto): Promise<Category | ApiResponse> {
    const existingCategory = await this.category.findOne({ where: { categoryId } });
    if (!existingCategory) {
      return new ApiResponse('error', -4003, 'Kategorija ne postoji');
    }

    if (data.parentCategoryId === categoryId) {
      return new ApiResponse('error', -4006, 'Kategorija ne može biti roditelj sama sebi');
    }

    // provjeri da li je prisutna podkategorije prije brisanja
    const subcategories = await this.category.find({ where: { parentCategoryId: categoryId } });
    if (subcategories.length > 0) {
      return new ApiResponse('error', -4007, 'Kategorija ima podkategorije i ne može biti izmijenjena');
    }

    existingCategory.name = data.name;
    existingCategory.imagePath = data.imagePath;
    existingCategory.parentCategoryId = data.parentCategoryId;

    const updatedCategory = await this.category.save(existingCategory);

    if (!updatedCategory) {
      return new ApiResponse('error', -4004, 'Kategorija nije mogla biti ažurirana');
    }

    return await this.findOne({
      where: { categoryId: updatedCategory.categoryId },
      relations: ['articles', 'parentCategory', 'categories', 'features'],
    });
  }

  async deleteCategory(categoryId: number): Promise<ApiResponse> {
    const existingCategory = await this.category.findOne({ where: { categoryId } });
    if (!existingCategory) {
      return new ApiResponse('error', -4003, 'Kategorija ne postoji');
    }

    // provjeri da li je prisutna podkategorije prije brisanja
    const subcategories = await this.category.find({ where: { parentCategoryId: categoryId } });
    if (subcategories.length > 0) {
      return new ApiResponse('error', -4007, 'Kategorija ima podkategorije i ne može biti obrisana');
    }

    const deleteResult = await this.category.delete({ categoryId });

    if (deleteResult.affected === 0) {
      return new ApiResponse('error', -4005, 'Kategorija nije mogla biti obrisana');
    }

    return new ApiResponse('success', 0, 'Kategorija je uspješno obrisana');
  }
}
