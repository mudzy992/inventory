import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { TypeOrmCrudService } from '@nestjsx/crud-typeorm';
import { AddArticleDto } from 'src/dtos/article/add.article.dto';
import { StorageConfig } from 'config/storage.config';
import createReport from 'docx-templates';
import { writeFileSync, readFileSync } from 'fs';
import { Article } from 'src/entities/Article';
import { StockFeature } from 'src/entities/StockFeature';
import { Documents } from 'src/entities/Documents';
import { Stock } from 'src/entities/Stock';
import { User } from 'src/entities/User';
import { ApiResponse } from 'src/misc/api.response.class';
import { Repository, Brackets } from 'typeorm';
import { ArticleTimeline } from 'src/entities/ArticleTimeline';

@Injectable()
export class ArticleService extends TypeOrmCrudService<Article> {
  constructor(
    @InjectRepository(Article)
    private readonly article: Repository<Article>,

    @InjectRepository(StockFeature)
    private readonly stockFeature: Repository<StockFeature>,

    @InjectRepository(Stock)
    private readonly stock: Repository<Stock>,

    @InjectRepository(Documents)
    private readonly document: Repository<Documents>,

    @InjectRepository(User)
    private readonly user: Repository<User>,

    @InjectRepository(ArticleTimeline)
    private readonly articleTimeline: Repository<ArticleTimeline>,
  ) {
    super(article);
  }
  /* dodavanje novog artikla (koristi add.article.dto.ts)
  Kreiranje novog metoda async je zbog toga što imamo rezultate koji su na await
  PRVI KORAK:createFullArticle(će uzimati podatke koji su tipa AddArtucleDto): vraćat će rezultat obećanje <Artikal ili grešku>
  Kao što vidimo vraća nam full artikal, a mi znamo da u tom full artiklu imamo cijenu, features, slike koji nam trebaju
  I to nije problem, jer ćemo dobiti articleId koji će biti na awaitu, i na osnovu tog articleId ćemo pridružiti cijenu, features, slike */

  async addNewArticle(
    stockId: number,
    data: AddArticleDto,
  ): Promise<Article | ApiResponse> {
    const existingStock = await this.stock.findOne({where:{stockId: stockId}});

    if(!existingStock) {
      return new ApiResponse('error', -2000, 'Artikal ne postoji u skladištu.')
    }

    const existingArticle = await this.article.findOne({ 
      where:{serialNumber : data.serialNumber},
      relations: ['user', 'stock'] 
    });

    let predao: string;
    let preuzeo: string;
  
    if (!existingArticle && data.status === 'zaduženo') {
      const skladiste = await this.user.findOne({where:{userId: 390}})
      predao = skladiste.fullname;
      const preuzeoKorisnik = await this.user.findOne({ where: { userId: data.userId } });
      preuzeo = preuzeoKorisnik.fullname;


      const newArticle: Article = new Article();
      newArticle.categoryId = existingStock.categoryId;
      newArticle.serialNumber = data.serialNumber;
      newArticle.invNumber = data.invNumber;
      newArticle.userId = data.userId;
      newArticle.status = data.status;
      newArticle.stockId = stockId;
      newArticle.comment = data.comment;
      /* Sada kada smo kreirali artikal, njega je potrebno snimiti u neku konstantu i čuvati ga na await 
        to radimo u ovom trenutku jer ćemo tako dobiti articleId, već ovdje artikal ide u bazu podataka (na returnu)*/

      const savedArticle = await this.article.save(newArticle);

      /* await this.changeStatus(savedArticle.articleId, data) */

      existingStock.valueAvailable = existingStock.valueAvailable -1;
      await this.stock.save(existingStock);  
    
        await this.createDocument( 
          savedArticle.articleId, 
          data.comment, 
          existingStock.name,
          data.invNumber,
          predao,
          preuzeo) 
      /* Dodati taj artikal u skladište */

      /* sada kada imamo articleId smješteno u savedArticle možemo za taj artikal dodati feature i njih snimiti isto u neku konstantu
        pošto je features jedan niz podataka (tako smo naveli u Dto, ali i planirali u bazi, artikal može imati više features-a) 
        tu se koristi for petlja konstrukcije za svaki varijantu feature dodaj određeni podatak i vrti u krug */
        /* za svaki slučaj je ovaj if, iako je u DTO postavljen kao opcionalan */
        if (data.features) {
          for (const feature of data.features) {
            const newStockFeatures = new StockFeature();
            newStockFeatures.stockId = stockId;
            newStockFeatures.featureId = feature.featureId;
            newStockFeatures.value = feature.value;
            await this.stockFeature.save(newStockFeatures);
          }
        }

      /* Vrati artikal na prikaz */
      return await this.findOne({ 
        where: { articleId: savedArticle.articleId },
        relations: ['user', 'stock', 'category', 'stock.stockFeatures', 'stock.stockFeatures.feature', 'articleTimelines', 'documents', 'upgradeFeatures'],
      });
    }
  } /* Kraj metoda za kreiranje novog artikla */


  async changeStatus(articleId: number, data: AddArticleDto): Promise<Article | ArticleTimeline | ApiResponse> {
    const existingArticle = await this.article.findOne({ 
      where:{articleId : articleId},
      relations: ['user', 'stock', 'articleTimelines'] 
    });

    const skladiste = await this.user.findOne({ where: {userId : 360}})

    let predao: string;
    let preuzeo: string;
    if (existingArticle){
      if (data.status === 'zaduženo' && existingArticle.status === 'zaduženo') {
        predao = existingArticle.user.fullname;
        const preuzeoKorisnik = await this.user.findOne({ where: { userId: data.userId } });
        preuzeo = preuzeoKorisnik.fullname;

        const existingArticleTimeline = await this.articleTimeline.findOne({ where: {articleId: existingArticle.articleId, userId: existingArticle.userId, documentId:existingArticle.documentId}})
        await this.articleTimeline.update(existingArticleTimeline, {status: "razduženo"})
        await this.article.update(existingArticle.articleId, { userId: data.userId, status: 'zaduženo', comment:data.comment });
        
        await this.createDocument( 
          existingArticle.articleId, 
          data.comment, 
          existingArticle.stock.name,
          data.invNumber,
          predao,
          preuzeo)

          return await this.findOne({ 
            where: { articleId: existingArticle.articleId },
          });
      } else if (data.status === 'razduženo' && existingArticle.status === 'zaduženo') {
        predao = existingArticle.user.fullname;
        preuzeo = skladiste.fullname;
        const existingArticleTimeline = await this.articleTimeline.findOne({ where: {articleId: existingArticle.articleId, userId: existingArticle.userId, documentId:existingArticle.documentId}})
        await this.articleTimeline.update(existingArticleTimeline, {status: "razduženo"})
        await this.article.update(existingArticle.articleId, { userId: skladiste.userId, status: 'razduženo', comment: data.comment});
        
        await this.createDocument( 
          existingArticle.articleId, 
          data.comment, 
          existingArticle.stock.name,
          data.invNumber,
          predao,
          preuzeo);

          const newValueAvailable = await existingArticle.stock.valueAvailable +1;
          await this.stock.update(existingArticle.stock.stockId, {valueAvailable: newValueAvailable})

          return await this.findOne({ 
            where: { articleId: existingArticle.articleId },
          });
      }
    
      if (data.status === 'zaduženo' && existingArticle.status === 'razduženo') {
        predao = skladiste.fullname;
        const preuzeoKorisnik = await this.user.findOne({ where: { userId: data.userId } });
        preuzeo = preuzeoKorisnik.fullname;

        await this.article.update(existingArticle.articleId, { userId: data.userId, status: 'zaduženo', comment: data.comment });
        await this.createDocument( 
          existingArticle.articleId, 
          data.comment, 
          existingArticle.stock.name,
          data.invNumber,
          predao,
          preuzeo)

          const newValueAvailable = await existingArticle.stock.valueAvailable -1;
          await this.stock.update(existingArticle.stock.stockId, {valueAvailable: newValueAvailable})
          return await this.findOne({ 
            where: { articleId: existingArticle.articleId },
          });
      }
    }
  }

  async getBySerialNumber(serialNumber: string): Promise<Article | null> {
    /* Mehanizam pronalaženja artikla u skladištu po sap broju */
    const serialnumber = await this.article.findOne(
      {where:{serialNumber : serialNumber},
      relations: ['user', 'user.job', 'user.department', 'user.location', 'stock', 'category', 'stock.stockFeatures', 'stock.stockFeatures.feature', 'articleTimelines', 'articleTimelines.document', 'articleTimelines.user', 'documents', 'upgradeFeatures']
    });
    if (serialnumber) {
      return serialnumber;
    }
    return null;
  }

  async articleSearchPaginationByStockId(stockId: number, perPage: number, offset: number, query: string) {
    const resultsQuery = this.article
      .createQueryBuilder('article')
      .leftJoin('article.user', 'user')
      .leftJoin('article.documents', 'documents')
      .where('article.stockId = :stockId', { stockId: stockId })
      .select(['article', 'user.fullname', 'user.userId', 'documents.path'])
      .take(perPage)
      .skip(offset);

    if (query) {
      resultsQuery.andWhere(
        new Brackets(qb => {
          qb.where('user.fullname LIKE :query', { query: `%${query}%` });
          qb.orWhere('article.serialNumber LIKE :query', { query: `%${query}%` });
          qb.orWhere('article.invNumber LIKE :query', { query: `%${query}%` });
          qb.orWhere('article.status LIKE :query', { query: `%${query}%` });
        }),
      );
    }

    const [results, totalResults] = await resultsQuery.getManyAndCount();

    return {
      results,
      total: totalResults,
    };
  }

  

//   async editArticle(
//     articleId: number,
//     data: EditFullArticleDto,
//   ): Promise<Article | ApiResponse> {
//     const existingArticle: Article = await this.article.findOne({where:{articleId: articleId}})
//     if (!existingArticle) {
//       return new ApiResponse('error', -1001, 'Artikal ne postoji u skladištu');
//     }
//     if (data.details !== null) {
//       this.article.update(existingArticle, {
//           name : data.details.name,
//           categoryId : data.categoryId,
//           excerpt : data.details.excerpt,
//           description : data.details.description,
//           concract : data.details.concract,
//         })
//         const savedArticle = await this.article.save(existingArticle);

//         if (!savedArticle) {
//           return new ApiResponse('error', -1002, 'Artikal nije moguće spasiti');
//         }
//     }
    
//     if (data.stock !== null) {
//       const existingArticleInStock = await this.stock.findOne({where:{articleId : articleId}})
//       this.stock.update(existingArticleInStock, {
//         valueOnConcract : data.stock.valueOnConcract,
//         valueAvailable : data.stock.valueAvailable,
//         sapNumber : data.stock.sap_number,
//       })
//     }

//      if (data.features !== null) {
//        await this.articleFeature.remove(await this.articleFeature.findOne({where:{articleId : articleId}}));
//       for (const feature of data.features) {
//         const newArticleFeature: ArticleFeature = new ArticleFeature();
//         newArticleFeature.articleId = articleId;
//         newArticleFeature.featureId = feature.featureId;
//         newArticleFeature.value = feature.value;
//         await this.articleFeature.save(newArticleFeature);
//       } 
//     }

//     return await this.findOne(
//       {where:{articleId:articleId},
//       relations: [
//         'category',
//         'articleFeature',
//         'features',
//         'articlesInStock',
//       ],
//     });
  
//   }
//  async changeStockExistArticle(
//     articleId: number,
//     data: AddArticleDto,
//   ): Promise<Stock> {
//     const existingStockArticle = await this.stock.findOne({where:{
//       articleId: articleId,
//     }});
//     if (existingStockArticle) {
//       await this.stock.remove(
//         await this.stock.findOne({where:{ articleId: articleId }}),
//       );
//       const newArticleStock: Stock = new Stock();
//       newArticleStock.articleId = articleId;
//       newArticleStock.valueOnConcract = data.stock.valueOnConcract;
//       newArticleStock.valueAvailable = data.stock.valueAvailable;
//       newArticleStock.sapNumber = data.sap_number;
//       await this.stock.save(newArticleStock);
//       return newArticleStock;
//     }
//   }


private async createDocument(
  articleId: number,
  comment: string,
  name: string,
  invNumber: string,
  predao: string,
  preuzeo: string,
) {
  let documentNumber: number;

  const lastRecord: Documents | undefined = await this.document.findOne({
    where:{},
    order: {
      createdDate: 'DESC'
    }
  })

  if (!lastRecord) {
    documentNumber = 1;
  } else {
    documentNumber = lastRecord.documentNumber + 1;
  }

 
  /* let currentYear = lastRecord ? new Date(lastRecord.created_date).getFullYear() : new Date().getFullYear(); */
  let currentYear;
  if (lastRecord && lastRecord.createdDate) {
    currentYear = new Date(lastRecord.createdDate).getFullYear();
  } else {
    currentYear = new Date().getFullYear();
  }

  if (currentYear === new Date().getFullYear()) {
      documentNumber = lastRecord ? lastRecord.documentNumber + 1 : 1;
  } else {
      documentNumber = 1;
      currentYear = new Date().getFullYear();
  }
  

  const newDoc : Documents = new Documents();
  newDoc.path = 'prenosnica' + documentNumber + '.docx';
  newDoc.documentNumber = documentNumber;
  newDoc.articleId = articleId;

  const savedDocument = await this.document.save(newDoc);
  
  const updateArticleTimeline:ArticleTimeline = await this.articleTimeline.findOne({where:{articleId:articleId}});
  
  await this.article.update(articleId, { documentId: savedDocument.documentsId});

  await this.articleTimeline.update(updateArticleTimeline.articleTimelineId, { documentId: savedDocument.documentsId})

  const direktor = await this.user.findOne({where:{jobId: 12}})

  const godina:number = new Date().getFullYear();

  let komentar = comment;
  try {
    const template = readFileSync(
      StorageConfig.prenosnica.template,
      /* StorageConfig.prenosnica.fullPath + 'templates/prenosnica.docx', */
    );
    const buffer = await createReport({
      template,
      data: {
        broj_prenosnice: documentNumber,
        predao_korisnik: predao,
        preuzeo_korisnik: preuzeo,
        inv_broj: invNumber,
        naziv: name,
        komentar: komentar,
        direktor: direktor.fullname,
        godina: godina
      },
    });
    writeFileSync(
      StorageConfig.prenosnica.destination +
        'prenosnica' +
        documentNumber +
        '.docx',
      buffer,
    );
  } catch (err) {
    console.log(err);
  }
}

} /* Kraj koda */
