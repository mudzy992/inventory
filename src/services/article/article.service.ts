import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { TypeOrmCrudService } from '@nestjsx/crud-typeorm';
import { AddArticleDto } from 'src/dtos/article/add.article.dto';
import { StorageConfig } from 'config/storage.config';
import createReport from 'docx-templates';
import { writeFileSync, readFileSync, existsSync, mkdirSync } from 'fs';
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

  async addNewArticle( // Dodavanje novog artikla sa skladišta
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

    const skladiste = await this.user.findOne({where:{userId: 390}})

    let predao: string;
    let preuzeo: string;
  
    if (!existingArticle && data.status === 'zaduženo') { //Ako artikal na postoji
      
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
  }


  async changeStatus(articleId: number, data: AddArticleDto): Promise<Article | ArticleTimeline | ApiResponse> { //Promjena statusa artikla
    const existingArticle = await this.article.findOne({ 
      where:{articleId : articleId},
      relations: ['user', 'stock', 'articleTimelines'] 
    });

    const skladiste = await this.user.findOne({ where: {userId : 390}})

    let predao: string;
    let preuzeo: string;
    if (existingArticle){
      if (data.status === 'zaduženo' && existingArticle.status === 'zaduženo') { // Ako zadužujemo artikla sa korisnika na korisnika tj. ako mu šaljemo status "zaduženo" i postojeći status je "zaduženo"
        predao = existingArticle.user.fullname; // Predao postojeći korisnik koji je onaj kojeg smo smjestili u existingArticle (za potrebe prenosnice)
        const preuzeoKorisnik = await this.user.findOne({ where: { userId: data.userId } }); //Tražimo korisnika kojeg za kojeg ID prosljeđujemo u data
        preuzeo = preuzeoKorisnik.fullname; // Uzimamo fullname od tog pronađenog korisnika (za potrebe prenosnice)

        //Da bi postavili status "razduženo", u vremenskoj liniji za artikal koji već ima status "zaduženo" jer ga zadužujem na drugo korisnika, moram da pronađem taj red u vremenskoj liniji
        //koji odgovara articleId, userId, documentId
        const existingArticleTimeline = await this.articleTimeline.findOne({ where: {articleId: existingArticle.articleId, userId: existingArticle.userId, documentId:existingArticle.documentId}})
        
        await this.articleTimeline.update(existingArticleTimeline, {status: "razduženo"}) // i u tom redu mjenjamo samo status "zaduženo" u "razduženo"

        await this.article.update(existingArticle.articleId, { userId: data.userId, status: 'zaduženo', comment:data.comment }); // vršimo izmjenu postojećeg artikla za stanje
          
        await this.createDocument( 
          existingArticle.articleId, 
          data.comment, 
          existingArticle.stock.name,
          data.invNumber,
          predao,
          preuzeo) // Čekamo da se artikal ažurira i da prebaci uredna stanja u ovu funkciju
          
          return await this.findOne({ 
            where: { articleId: existingArticle.articleId },
          });
      } else if (data.status === 'razduženo' && existingArticle.status === 'zaduženo') { // Ako je postojeći status "zadužueno", a šaljemo "razduženo" - tj. RAZDUŽUJEMO ARTIKAL. (SA KREIRANJEM KORISNIKA ZA SKLADIŠTE, TJ. PODRUŽNICU DO OVOG STANJA NIKADA DOĆI NEĆE)
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
      } else if (data.status === 'otpisano'){
        predao = existingArticle.user.fullname;
        preuzeo = skladiste.fullname;
        const existingArticleTimeline = await this.articleTimeline.findOne({ where: {articleId: existingArticle.articleId, userId: existingArticle.userId, documentId:existingArticle.documentId}})

        await this.articleTimeline.update(existingArticleTimeline, {status: "razduženo"})

        await this.article.update(existingArticle.articleId, { userId: skladiste.userId, status: 'otpisano', comment: 'OTPIS: ' + data.comment});

        await this.createDocument( 
          existingArticle.articleId, 
          data.comment, 
          existingArticle.stock.name,
          data.invNumber,
          predao,
          preuzeo);

          if(existingArticle.status === 'razduženo') {
            const newValueAvailable = await existingArticle.stock.valueAvailable -1;
            await this.stock.update(existingArticle.stock.stockId, {valueAvailable: newValueAvailable})
          }

          return await this.findOne({ 
            where: { articleId: existingArticle.articleId },
          });
      }
    
      if (data.status === 'zaduženo' && existingArticle.status === 'razduženo') { // Razduženi ponovo zadužujemo
        predao = skladiste.fullname;
        const preuzeoKorisnik = await this.user.findOne({ where: { userId: data.userId } });
        preuzeo = preuzeoKorisnik.fullname;

        this.article.update(existingArticle.articleId, { userId: data.userId, status: 'zaduženo', comment: data.comment });

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
  newDoc.path = currentYear + '/prenosnica' + documentNumber + '.docx';
  newDoc.documentNumber = documentNumber;
  newDoc.articleId = articleId;

  const savedDocument = await this.document.save(newDoc);
  if(!savedDocument){
    new ApiResponse("error", -9001, "Greška prilikom snimanja Dokumenta. Desila se u Article servisu u funkciju za promjenu status.") // Ako se desi greška prilikom snimanja, povuću grešku
  }

  const preuzeoKorisnik = await this.user.findOne({where:{fullname: preuzeo}}) // Za porebe articleTimeline da izvučem userId (šanse us minimalne da dođe do neke zabune)
  const artikal = await this.article.findOne({where: {articleId: articleId}}) // Za potrebe articleTimeline da izvučem serialNumber, status i invNumber (iako inv imam proslijeđen)

  const newArticleTimeline: ArticleTimeline = new ArticleTimeline()
  newArticleTimeline.articleId = articleId; // articleId koji prosljeđujemo je logično uvijek taj
  newArticleTimeline.userId = preuzeoKorisnik.userId; // userId koji smo izvukli iz preuzeoKorisnik
  newArticleTimeline.documentId = savedDocument.documentsId; // nova prenosnica koja je kreirana u koraku ispred
  newArticleTimeline.serialNumber = artikal.serialNumber; // izvukli iz konstante artikal
  newArticleTimeline.status = artikal.status; // obzirom da vršim update status za taj artikal u tabeli article sa await, znači da je taj status mjerodavan uvijek za novi articleTimeline
  newArticleTimeline.invNumber = artikal.invNumber; // Inventurni broj je vezan samo za taj artikal
  newArticleTimeline.comment = artikal.comment; // razlog za promjenu statusa

  const savedArticleTimline = await this.articleTimeline.save(newArticleTimeline) // Snimanje nove vremenske linije
  if(!savedArticleTimline){
    new ApiResponse("error", -9000, "Greška prilikom snimanja ArticleTimeline. Desila se u Article servisu u funkciju za promjenu status.") // Ako se desi greška prilikom snimanja, povuću grešku
  }

  await this.article.update(articleId, { documentId: savedDocument.documentsId}); // U bilo kojem slučaju kada dodje do ove funkcije za kreiranje dokumenta, artikal uvijek postoji pod tim articleId, vrši se update njegovog documentId jer je dobijem tak u ovoj funkciju

  const direktor: User = await this.user.findOne({where:{jobId: 12}}) // Pronalazimo u tabeli user direktora jer je jobId za direktora 12 i smještamo ga u ovu konstantu

  const godina:number = new Date().getFullYear(); // Za potrebe godine na prenosnici smještamo tekuću godinu u ovu konstantu

  try { 
    const template = readFileSync(
      StorageConfig.prenosnica.template,
    );
    
    const folderPath = StorageConfig.prenosnica.destination + currentYear + '/';
  
    if (!existsSync(folderPath)) {
      try {
        mkdirSync(folderPath, { recursive: true });
      } catch (mkdirErr) {
        return new ApiResponse("error", -9008, "Greška prilikom kreiranja novog foldera za prenosnice. Error: " + mkdirErr)
      }
    }
  
    const buffer = await createReport({
      template,
      data: {
        broj_prenosnice: documentNumber,
        predao_korisnik: predao,
        preuzeo_korisnik: preuzeo,
        inv_broj: invNumber,
        naziv: name,
        komentar: comment,
        direktor: direktor.fullname,
        godina: godina,
      },
    });
  
    writeFileSync(
      folderPath + 'prenosnica' + documentNumber + '.docx',
      buffer,
    );
  } catch (err) {
    return new ApiResponse('error', -9009, "Greška prilikom pravljenja prenosnice. Greška: " + err)
  }
  
}
} /* Kraj koda */
