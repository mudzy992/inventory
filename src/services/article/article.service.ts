import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { TypeOrmCrudService } from '@nestjsx/crud-typeorm';
import { AddArticleDto } from 'src/dtos/article/add.article.dto';
import { EditArticleInStockDto } from 'src/dtos/stock/edit.article.in.stock.dto';
import { Article } from 'src/entities/Article';
import { ArticleFeature } from 'src/entities/ArticleFeature';
import { Stock } from 'src/entities/Stock';
import { ApiResponse } from 'src/misc/api.response.class';
import { Repository } from 'typeorm';
import { dataCollectionPhase } from 'typeorm-model-generator/dist/src/Engine';

@Injectable()
export class ArticleService extends TypeOrmCrudService<Article> {
  constructor(
    @InjectRepository(Article)
    private readonly article: Repository<Article>,

    @InjectRepository(ArticleFeature)
    private readonly articleFeature: Repository<ArticleFeature>,

    @InjectRepository(Stock)
    private readonly stock: Repository<Stock>,
  ) {
    super(article);
  }
  /* dodavanje novog artikla (koristi add.article.dto.ts)
  Kreiranje novog metoda async je zbog toga što imamo rezultate koji su na await
  PRVI KORAK:createFullArticle(će uzimati podatke koji su tipa AddArtucleDto): vraćat će rezultat obećanje <Artikal ili grešku>
  Kao što vidimo vraća nam full artikal, a mi znamo da u tom full artiklu imamo cijenu, features, slike koji nam trebaju
  I to nije problem, jer ćemo dobiti articleId koji će biti na awaitu, i na osnovu tog articleId ćemo pridružiti cijenu, features, slike */

  async createNewArticleInStock(
    data: AddArticleDto,
  ): Promise<Article | ApiResponse> {
    const newArticle: Article = new Article();
    newArticle.name = data.name;
    newArticle.categoryId = data.categoryId;
    newArticle.excerpt = data.excerpt;
    newArticle.description = data.description;
    newArticle.concract = data.concract;
    newArticle.comment = data.comment;
    /* Sada kada smo kreirali artikal, njega je potrebno snimiti u neku konstantu i čuvati ga na await 
      to radimo u ovom trenutku jer ćemo tako dobiti articleId, već ovdje artikal ide u bazu podataka (na returnu)*/

    const savedArticle = await this.article.save(newArticle);
    /* Dodati taj artikal u skladište */

    /* sada kada imamo articleId smješteno u savedArticle možemo za taj artikal dodati feature i njih snimiti isto u neku konstantu
      pošto je features jedan niz podataka (tako smo naveli u Dto, ali i planirali u bazi, artikal može imati više features-a) 
      tu se koristi for petlja konstrukcije za svaki varijantu feature dodaj određeni podatak i vrti u krug */

    for (const feature of data.features) {
      /* Ali kao što je i slučaj iznad features-e smještamo isto u jednu konstantu */
      const newArticleFeatures: ArticleFeature = new ArticleFeature();
      newArticleFeatures.articleId = savedArticle.articleId;
      newArticleFeatures.featureId = feature.featureId;
      newArticleFeatures.value = feature.value;
      /* Uraditi snimanje tog articleFeatures */
      await this.articleFeature.save(newArticleFeatures);
    }

    const newArticleInStock: Stock = new Stock();
    newArticleInStock.articleId = savedArticle.articleId;
    newArticleInStock.valueOnConcract = data.valueOnConcract;
    newArticleInStock.valueAvailable = data.valueAvailable;
    newArticleInStock.sapNumber = data.sap_number;

    await this.stock.save(newArticleInStock);

    /* Vrati artikal na prikaz */
    return await this.findOne(savedArticle.articleId, {
      relations: ['category', 'articleFeature', 'features', 'articlesInStock'],
    });
  } /* Kraj metoda za kreiranje novog artikla */

  async getBySapNumber(sapNumber: string): Promise<Stock | null> {
    /* Mehanizam pronalaženja artikla u skladištu po sap broju */
    const sapnumber = await this.stock.findOne({ sapNumber: sapNumber });
    if (sapnumber) {
      return sapnumber;
    }
    return null;
  }

  async changeArticleAvailableValueInStock(
    articleId: number,
    newArticleValue: number,
  ): Promise<Article | ApiResponse> {
    const existingArticleInStock: Stock = await this.stock.findOne({
      articleId: articleId,
    });

    if (!existingArticleInStock) {
      console.log(existingArticleInStock);
      return new ApiResponse('error', -1001, 'artikal ne postoji u skladištu');
    }

    const newArticleDataInStock = new Stock();
    console.log(existingArticleInStock);
    newArticleDataInStock.valueAvailable =
      existingArticleInStock.valueAvailable + newArticleValue;
    console.log(newArticleDataInStock);
    await this.stock.save(newArticleDataInStock);

    return await this.findOne(articleId, {
      relations: ['category', 'articleFeature', 'features', 'articlesInStock'],
    });
  }
} /* Kraj koda */
