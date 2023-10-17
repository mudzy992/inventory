import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { TypeOrmCrudService } from '@nestjsx/crud-typeorm';
import { AddArticleDto } from 'src/dtos/article/add.article.dto';
import { EditFullArticleDto } from 'src/dtos/article/edit.full.article.dto';
import { Article } from 'src/entities/Article';
import { ArticleFeature } from 'src/entities/ArticleFeature';
import { Stock } from 'src/entities/Stock';
import { ApiResponse } from 'src/misc/api.response.class';
import { Repository } from 'typeorm';


@Injectable()
export class ArticleService extends TypeOrmCrudService<Article> {
  constructor(
    @InjectRepository(Article)
    private readonly articleRepository: Repository<Article>,

    @InjectRepository(ArticleFeature)
    private readonly articleFeatureRepository: Repository<ArticleFeature>,

    @InjectRepository(Stock)
    private readonly stockRepository: Repository<Stock>,
  ) {
    super(articleRepository);
  }

  async createNewArticleInStock(data: AddArticleDto): Promise<Article | ApiResponse> {
    const sapNumber = data.sap_number;
    const existingArticle = await this.getBySapNumber(sapNumber);

    if (existingArticle) {
      return new ApiResponse('error', -1000, 'Artikal već postoji u skladištu');
    }

    const newArticle: Article = new Article();
    newArticle.name = data.name;
    newArticle.categoryId = data.categoryId;
    newArticle.excerpt = data.excerpt;
    newArticle.description = data.description;
    newArticle.concract = data.concract;
    newArticle.sapNumber = sapNumber;

    const savedArticle = await this.articleRepository.save(newArticle);

    for (const feature of data.features) {
      const newArticleFeature: ArticleFeature = new ArticleFeature();
      newArticleFeature.articleId = savedArticle.articleId;
      newArticleFeature.featureId = feature.featureId;
      newArticleFeature.value = feature.value;

      await this.articleFeatureRepository.save(newArticleFeature);
    }

    const newArticleInStock: Stock = new Stock();
    newArticleInStock.articleId = savedArticle.articleId;
    newArticleInStock.valueOnConcract = data.stock.valueOnConcract;
    newArticleInStock.valueAvailable = data.stock.valueAvailable;
    newArticleInStock.sapNumber = sapNumber;

    await this.stockRepository.save(newArticleInStock);

    return await this.articleRepository.findOne({
      where: { articleId: savedArticle.articleId },
      relations: ['category', 'articleFeature', 'features', 'articlesInStock'],
    });
  }

  async getBySapNumber(sapNumber: string): Promise<Article | null> {
    return this.articleRepository.findOne({where:{ sapNumber }});
  }
  

  async editFullArticle(
    articleId: number,
    data: EditFullArticleDto,
  ): Promise<Article | ApiResponse> {
    const existingArticle: Article = await this.articleRepository.findOne({ where: { articleId: articleId } });
  
    if (!existingArticle) {
      return new ApiResponse('error', -1001, 'Artikal ne postoji u skladištu');
    }
  
    if (data.details !== null) {
      this.articleRepository.update(existingArticle, {
        name: data.details.name,
        categoryId: data.categoryId,
        excerpt: data.details.excerpt,
        description: data.details.description,
        concract: data.details.concract,
      });
  
      const savedArticle = await this.articleRepository.save(existingArticle);
  
      if (!savedArticle) {
        return new ApiResponse('error', -1002, 'Artikal nije moguće spasiti');
      }
    }
  
    if (data.stock !== null) {
      const existingArticleInStock = await this.stockRepository.findOne({ where: { articleId: articleId } });
  
      if (existingArticleInStock) {
        this.stockRepository.update(existingArticleInStock, {
          valueOnConcract: data.stock.valueOnConcract,
          valueAvailable: data.stock.valueAvailable,
          sapNumber: data.stock.sap_number,
        });
      }
    }
  
    if (data.features !== null) {
      await this.articleFeatureRepository.remove(
        await this.articleFeatureRepository.findOne({ where: { articleId: articleId } })
      );
  
      for (const feature of data.features) {
        const newArticleFeature: ArticleFeature = new ArticleFeature();
        newArticleFeature.articleId = articleId;
        newArticleFeature.featureId = feature.featureId;
        newArticleFeature.value = feature.value;
        await this.articleFeatureRepository.save(newArticleFeature);
      }
    }
  
    return await this.articleRepository.findOne({
      where: { articleId: articleId },
      relations: [
        'category',
        'articleFeature',
        'features',
        'articlesInStock',
      ],
    });
  }
  


async changeStockExistArticle(articleId: number, data: AddArticleDto): Promise<Stock> {
  const existingStock = await this.stockRepository.findOne({ where: { articleId: articleId } });

  if (existingStock) {
    await this.stockRepository.remove(existingStock);

    const newArticleStock: Stock = new Stock();
    newArticleStock.articleId = articleId; // Ovdje koristimo 'articleId' umjesto 'article'
    newArticleStock.valueOnConcract = data.stock.valueOnConcract;
    newArticleStock.valueAvailable = data.stock.valueAvailable;
    newArticleStock.sapNumber = data.sap_number;

    await this.stockRepository.save(newArticleStock);

    return newArticleStock;
  }
}

}
