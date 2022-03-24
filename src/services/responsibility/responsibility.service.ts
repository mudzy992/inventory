import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { TypeOrmCrudService } from '@nestjsx/crud-typeorm';
import { AddEmployeArticleDto } from 'src/dtos/user/add.employe.article.dto';
import { DebtItems } from 'src/entities/DebtItems';
import { Destroyed } from 'src/entities/Destroyed';
import { Stock } from 'src/entities/Stock';
import { User } from 'src/entities/User';
import { Responsibility } from 'src/entities/Responsibility';
import { ApiResponse } from 'src/misc/api.response.class';
import { Repository } from 'typeorm';
import { UserArticle } from 'src/entities/UserArticle';
import { Documents } from 'src/entities/Documents';
import { StorageConfig } from 'config/storage.config';
import { writeFileSync, readFileSync } from 'fs';
import createReport from 'docx-templates';
import { Article } from 'src/entities/Article';

@Injectable()
export class ResponsibilityService extends TypeOrmCrudService<Responsibility> {
  constructor(
    @InjectRepository(Responsibility)
    private readonly responsibility: Repository<Responsibility>,
    @InjectRepository(Stock)
    private readonly stock: Repository<Stock>,
    @InjectRepository(Destroyed)
    private readonly destroyed: Repository<Destroyed>,
    @InjectRepository(DebtItems)
    private readonly debtItems: Repository<DebtItems>,
    @InjectRepository(User)
    private readonly user: Repository<User>,
    @InjectRepository(UserArticle)
    private readonly userArticle: Repository<UserArticle>,
    @InjectRepository(Documents)
    private readonly document: Repository<Documents>,
    @InjectRepository(Article)
    private readonly article: Repository<Article>,
  ) {
    super(responsibility);
  }
  async addArticleToEmploye(
    userId: number,
    data: AddEmployeArticleDto,
  ): Promise<User | Stock | Responsibility | UserArticle | ApiResponse> {
    /* 
    U privim tražim artikal po SB u responsibility, debt i destroy
    - Ako se artikal nalazi u responsibility i želim ga zadužiti ponovo na novog korisnika
      - Izvširiti provjeru ako je već artikal sa SB zadužen na traženog korisnika
        - Ako jeste, pronaći red u userArticle za tog korisnika
          izvršiti update polja statusa u userArticle na "razduženo", pod tim korisnikom
        - Nakon toga izvšriti prvo logiku kreiranja prenosnice, jer nam trebaju podaci o korisniku za nju
        - Izvširi logiku brisanja polja iz responsibility tabele
        - Izvšiti logiku zaduženja korisnika
    - Ako se artikal nalazi u debt, i želimo ga zadužiti
      - Prvo kreirati prenosnicu, jer nam trebaju podaci u njoj iz debta
      - Nakon toga brišemo artikal iz debta
      - i posljednji korak, logika zaduženja

    OPIS LOGIKE KADA SE ARTIKAL VUČE IZ STACKA
    */

    /* Provjera da li je artikal zadužen */
    const exResponsibility: Responsibility = await this.responsibility.findOne({
      serialNumber: data.serialNumber,
    });

    const exDebt: DebtItems = await this.debtItems.findOne({
      serialNumber: data.serialNumber,
    });

    const exDestroyed: Destroyed = await this.destroyed.findOne({
      serialNumber: data.serialNumber,
    });

    if(!exResponsibility) {
        const checkArticleInStock: Stock = await this.stock.findOne({
        articleId: data.articleId,
      });
      if (!checkArticleInStock) {
        return new ApiResponse( 
          'error',
          -2011,
          'Traženi artikal ne postoji u bazi podataka',
        );
      }
      if (checkArticleInStock.valueAvailable === 0) {
        return new ApiResponse(
          'error',
          -2005,
          'Na stanju više nema traženog artikla',
        );
      }
    }
    
    if (exResponsibility) {
      if (exResponsibility.userId === userId) {
        return new ApiResponse(
          'error',
          -2002,
          'Artikal sa traženim serijskim brojem je već zadužen na korisnika',
        );
      } else if (exResponsibility.userId !== userId) {
        const ua: UserArticle = await this.userArticle.findOne({
          userArticleId: exResponsibility.userArticleId,
        });
        this.userArticle.update(ua, {
          status: 'razduženo',
          comment: data.comment,
        });
        await this.createDocument(1, '', '', '', '', '', userId, data);
        await this.responsibility.remove(exResponsibility);
        return this.addArticleInResponsibility(userId, data);
      }
    } else if (exDebt) {
      await this.createDocument(1, '', '', '', '', '', userId, data);
      await this.debtItems.remove(exDebt);
      return this.addArticleInResponsibility(userId, data);
    } else if (exDestroyed) {
      return new ApiResponse(
        'error',
        -2007,
        'Artikal sa traženim serijskim brojem je već uništen.',
      );
    }

    await this.createDocument(1, '', '', '', '', '', userId, data);
    return this.addArticleInResponsibility(userId, data);
  }

  private async createDocument(
    id: number,
    predao: string,
    preuzeo: string,
    inv: string,
    naziv: string,
    komentar: string,
    userId,
    data,
  ) {
    const builder = await this.document.createQueryBuilder(
      `SELECT (*) documents getLastRecord ORDER BY documents_id DESC LIMIT 1`,
    );
    const dokumenti = await builder.getMany();
    id = Number(dokumenti.length) + 1;

    const exRes: Responsibility = await this.responsibility.findOne({
      serialNumber: data.serialNumber,
    });

    if (!exRes) {
      const exDebt: DebtItems = await this.debtItems.findOne({
        serialNumber: data.serialNumber
      })

      if (exDebt) {
        const predaoKorisnik: User = await this.user.findOne({
          userId: exDebt.userId,
        });
        predao = predaoKorisnik.forname + ' ' + predaoKorisnik.surname;
        console.log("undefined");
      } else {
        predao = 'Skladište'
      }
      predao = 'Skladište'
    }
    if (exRes){
      const predaoKorisnik: User = await this.user.findOne({
        userId: exRes.userId,
      });
      predao = predaoKorisnik.forname + ' ' + predaoKorisnik.surname;
      console.log('defined')
    } 

    const preuzeoKorisnik: User = await this.user.findOne({
      userId: userId,
    });
    preuzeo = preuzeoKorisnik.forname + ' ' + preuzeoKorisnik.surname;

    const articleName: Article = await this.article.findOne({
      articleId: data.articleId,
    });
    naziv = articleName.name;
    inv = data.serialNumber;
    komentar = data.comment;
    try {
      const template = readFileSync(
        StorageConfig.prenosnica.fullPath + 'templates/prenosnica.docx',
      );
      const buffer = await createReport({
        template,
        data: {
          broj_prenosnice: id,
          predao_korisnik: predao,
          preuzeo_korisnik: preuzeo,
          inv_broj: inv,
          naziv: naziv,
          komentar: komentar,
        },
      });
      writeFileSync(
        StorageConfig.prenosnica.fullPath + 'report' +
          Number(dokumenti.length + 1) +
          '.docx',
        buffer,
      );
    } catch (err) {
      console.log(err);
    }
  }

  private async addArticleInResponsibility(
    user: number,
    data: AddEmployeArticleDto,
  ) {
    const builder = await this.document.createQueryBuilder(
      `SELECT (*) documents getLastRecord ORDER BY documents_id DESC LIMIT 1`,
    );
    const dokumenti = await builder.getMany();

    const newDocument: Documents = new Documents();
    newDocument.path = '/prenosnica' + Number(dokumenti.length + 1) + '.docx';
    newDocument.documentNumber = dokumenti.length + 1;

    const savedDocument = await this.document.save(newDocument);
    if (!savedDocument) {
      return new ApiResponse('error', -2020, 'Prenosnica nije kreirana');
    }

    const newUserArticleData: UserArticle = new UserArticle();
    newUserArticleData.documentId = savedDocument.documentsId;
    newUserArticleData.userId = user;
    newUserArticleData.serialNumber = data.serialNumber;
    newUserArticleData.articleId = data.articleId;
    newUserArticleData.comment = "Zaduženje nove opreme";
    newUserArticleData.status = 'zaduženo';

    const savedUserArticle = await this.userArticle.save(newUserArticleData);
    if (!savedUserArticle) {
      return new ApiResponse(
        'error',
        -2021,
        'User Article ne može biti kreiran' /* Iako do ove greške teško da će doći */,
      );
    }

    const newResponsibility: Responsibility = new Responsibility();
    newResponsibility.userArticleId = savedUserArticle.userArticleId;
    newResponsibility.userId = user;
    newResponsibility.articleId = data.articleId;
    newResponsibility.value = data.value;
    newResponsibility.status = 'zaduženo';
    newResponsibility.serialNumber = data.serialNumber;

    const savedNewResponsibility = await this.responsibility.save(
      newResponsibility,
    );

    if (!savedNewResponsibility) {
      return new ApiResponse(
        'error',
        -2003,
        'Artikal ne može biti zadužen za tog radnika',
      );
    }

    /* Provjera ako artikla nema na stanju više na skladištu da se zaduži, i ako ima skini određeni broj */
    const articleInStock: Stock = await this.stock.findOne({
      articleId: data.articleId,
    });

    await this.stock.remove(articleInStock); /* Brisati red */
    const newArticleStock: Stock =
      await new Stock(); /* Primjer novog skladišta */
    newArticleStock.articleId = data.articleId;
    newArticleStock.valueOnConcract = articleInStock.valueOnConcract;
    newArticleStock.valueAvailable =
      articleInStock.valueAvailable - savedNewResponsibility.value;
    newArticleStock.sapNumber = articleInStock.sapNumber;
    await this.stock.save(newArticleStock);

    return await this.responsibility.findOne({
      where: { articleId: data.articleId },
      relations: ['article', 'user', 'userArticle'],
    });

    /* FUNKCIJE */
  }
} /* KRAJ KODA */
/* Iz razloga što ne brišem iz userArticle stanje zaduženog artikla, dolazi do zabune u aplikaciji, gdje se dešava da sam artikal koji je bio
zadužen na radnik, razdužio ga, ali ostao je u evidenciji userArticle sa statusom zadužen, i samim tim funkciju otpisivanja ne radi kako treba, 
jer u tom trenutku trenutni artikal nije ustvari zadužen (otpisan je već ranije ali stoji u evidenciji), i kada se pokrene fukncija otpisivanja,
ona ustvari otpiše, već razduženi artikal sa korisnika. Da bi se sve to izbjeglo, potrebno je ipak izvršiti evidenciju razdužena i otpisivanja u posebnim tabelama DONE

Uraditi funkcije da se rastereti kod, i malo reorganizuje jer ima kodova koji se ponavljaju */
