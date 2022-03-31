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
    newArticle.sapNumber = data.sap_number;
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
    newArticleInStock.valueOnConcract = data.stock.valueOnConcract;
    newArticleInStock.valueAvailable = data.stock.valueAvailable;
    newArticleInStock.sapNumber = data.sap_number;

    await this.stock.save(newArticleInStock);

    /* Vrati artikal na prikaz */
    return await this.findOne(savedArticle.articleId, {
      relations: [
        'category',
        'articleFeature',
        'features',
        'articlesInStock',
        'destroyeds',
      ],
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

  async editFullArticle(
    articleId: number,
    data: EditFullArticleDto,
  ): Promise<Article | ApiResponse> {
    const existingArticle: Article = await this.article.findOne(articleId, {
      relations: ['articlesInStock', 'articleFeature'],
    });

    if (!existingArticle) {
      return new ApiResponse('error', -1001, 'Artikal ne postoji u skladištu');
    }
    existingArticle.name = data.name;
    existingArticle.categoryId = data.categoryId;
    existingArticle.excerpt = data.excerpt;
    existingArticle.description = data.description;
    existingArticle.concract = data.concract;
    existingArticle.comment = data.comment;

    const savedArticle = await this.article.save(existingArticle);

    if (!savedArticle) {
      return new ApiResponse('error', -1002, 'Artikal nije moguće spasiti');
    }

    if (data.stock !== null) {
      await this.stock.remove(
        await this.stock.findOne({ articleId: articleId }),
      );
      const newArticleStock: Stock = new Stock();
      newArticleStock.articleId = articleId;
      newArticleStock.valueOnConcract = data.stock.valueOnConcract;
      newArticleStock.valueAvailable = data.stock.valueAvailable;
      newArticleStock.sapNumber = data.stock.sap_number;
      await this.stock.save(newArticleStock);
    }

    if (data.features !== null) {
      await this.articleFeature.remove(existingArticle.articleFeature);
      for (const feature of data.features) {
        const newArticleFeature: ArticleFeature = new ArticleFeature();
        newArticleFeature.articleId = articleId;
        newArticleFeature.featureId = feature.featureId;
        newArticleFeature.value = feature.value;
        await this.articleFeature.save(newArticleFeature);
      }
    }

    return await this.findOne(articleId, {
      relations: [
        'category',
        'articleFeature',
        'features',
        'articlesInStock',
        'destroyeds',
      ],
    });
  }
  async changeStockExistArticle(
    articleId: number,
    data: AddArticleDto,
  ): Promise<Stock> {
    const existingStockArticle = await this.stock.findOne({
      articleId: articleId,
    });
    if (existingStockArticle) {
      await this.stock.remove(
        await this.stock.findOne({ articleId: articleId }),
      );
      const newArticleStock: Stock = new Stock();
      newArticleStock.articleId = articleId;
      newArticleStock.valueOnConcract = data.stock.valueOnConcract;
      newArticleStock.valueAvailable = data.stock.valueAvailable;
      newArticleStock.sapNumber = data.sap_number;
      await this.stock.save(newArticleStock);
      return newArticleStock;
    }
  }
} /* Kraj koda */
