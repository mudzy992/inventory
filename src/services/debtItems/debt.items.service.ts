import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { TypeOrmCrudService } from '@nestjsx/crud-typeorm';
import { AddEmployeArticleDto } from 'src/dtos/user/add.employe.article.dto';
import { DebtItems } from 'src/entities/DebtItems';
import { Destroyed } from 'src/entities/Destroyed';
import { Responsibility } from 'src/entities/Responsibility';
import { Stock } from 'src/entities/Stock';
import { User } from 'src/entities/User';
import { UserArticle } from 'src/entities/UserArticle';
import { ApiResponse } from 'src/misc/api.response.class';
import { Repository } from 'typeorm';
import { Documents } from 'src/entities/Documents';
import { StorageConfig } from 'config/storage.config';
import { writeFileSync, readFileSync } from 'fs';
import createReport from 'docx-templates';
import { Article } from 'src/entities/Article';

@Injectable()
export class DebtItemsService extends TypeOrmCrudService<DebtItems> {
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
    super(debtItems);
  }
  async addArticleToEmploye(
    userId: number,
    data: AddEmployeArticleDto,
  ): Promise<DebtItems | Stock | Responsibility | ApiResponse> {
    /* NOVI MEHANIZAM - nije još implementirano
    - Provjera da li je artikal već razdužen sa korisnika sa tim SB, ako jeste izbaciti grešku
      - Ako artikal nije razdužen, izvršiti provjeru da li se artikal nalazi u responsibility
        pod tim korisnikom i SB, ako jeste izvršiti logiku koda za razduživanje
      - Ako se artikal ne nalazi ni u responsibility, povući grešku da artikal ne postoji
    */

    const exDebt : DebtItems = await this.debtItems.findOne({ 
      userId: userId,
      serialNumber: data.serialNumber
    })

    if (exDebt) {
      return new ApiResponse(
        'error',
        -2008,
        'Artikal sa traženim serijskim brojem je već razdužen.',
      );
    }
    if (!exDebt) {
      const exRes : Responsibility = await this.responsibility.findOne({ 
        serialNumber: data.serialNumber,
      })
      if (exRes) {
        await this.createDocument(1, '', '', '', '', '', userId, data);
        return this.addDebtArticle(userId, data)
      }
      if (!exRes) {
        return new ApiResponse(
          'error',
          -2011,
          'Oprema nema zaduženje, da bi se izvršilo razduženje',
        );
      }
      const exDest : Destroyed = await this.destroyed.findOne({
        userId: userId,
        serialNumber: data.serialNumber
      })
      if (exDest) {
        return new ApiResponse(
          'error',
          -2007,
          'Artikal sa traženim serijskim brojem je već uništen.',
        );
      }

      return new ApiResponse(
        'error',
        -2011,
        'Artikal sa traženim serijskim brojem ne postoji.',
      );
    }
  } /* FUNKCIJE */
  
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
        serialNumber: data.serialNumber,
      });

      if (exDebt) {
        const predaoKorisnik: User = await this.user.findOne({
          userId: exDebt.userId,
        });
        predao = predaoKorisnik.forname + ' ' + predaoKorisnik.surname;
      } else {
        predao = 'Skladište';
      }
      predao = 'Skladište';
    }
    if (exRes) {
      const predaoKorisnik: User = await this.user.findOne({
        userId: exRes.userId,
      });
      predao = predaoKorisnik.forname + ' ' + predaoKorisnik.surname;
    }
  
    const articleName: Article = await this.article.findOne({
      articleId: data.articleId,
    });
    naziv = articleName.name;
    inv = data.serialNumber;
    komentar = data.comment;
    preuzeo = 'Skladište'
    try {
      const template = readFileSync(
        StorageConfig.prenosnica.template,
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
        StorageConfig.prenosnica.destination +
          'prenosnica' +
          Number(dokumenti.length + 1) +
          '.docx',
        buffer,
      );
    } catch (err) {
      console.log(err);
    }
  }
  private async addDebtArticle(user: number, data: AddEmployeArticleDto) {
    const builder = await this.document.createQueryBuilder(
      `SELECT (*) documents getLastRecord ORDER BY documents_id DESC LIMIT 1`,
    );
    const dokumenti = await builder.getMany();

    const newDocument: Documents = new Documents();
    newDocument.path = 'prenosnica' + Number(dokumenti.length + 1) + '.docx';
    newDocument.documentNumber = dokumenti.length + 1;
    newDocument.articleId = data.articleId;

    const savedDocument = await this.document.save(newDocument);
    if (!savedDocument) {
      return new ApiResponse(
        'error',
        -2020,
        'Prenosnica nije kreirana',
      );
    }

    /* Izvlačimo artikal iz responsibilitiy koji odgovara našem dto, te isti
    brišemo iz responsibility tabele, jer nije više zadužen, razdužuje se
    await koristim da bi izvukao value stanje */
    const resArticle: Responsibility = await this.responsibility.findOne({
     /*  userId: user, */
      serialNumber: data.serialNumber,
      articleId: data.articleId,
    });
    const value = await resArticle.value;
    await this.responsibility.remove(resArticle);

    /* Sada kada imam kreiran artikal u debt tabeli, posjedujem debtId,
    vršim evidenciju artikla u UserArticle */
    const newUserArticleData: UserArticle = new UserArticle();
    newUserArticleData.documentId = savedDocument.documentsId;
    newUserArticleData.articleId = data.articleId;
    newUserArticleData.userId = user;
    newUserArticleData.serialNumber = data.serialNumber;
    newUserArticleData.comment = data.comment;
    newUserArticleData.status = 'razduženo';
    newUserArticleData.invBroj = data.invBroj;

    const savedUserArticle = await this.userArticle.save(newUserArticleData);

    if (!savedUserArticle) {
      return new ApiResponse('error', -2006, 'Artikal nije zadužen na radnika');
    }

    /* Kreiramo novi artikal u debt items i snimamo ga, kako bi dobili
    debtId */
    const newDebtArticle: DebtItems = new DebtItems();
    newDebtArticle.userArticleId = savedUserArticle.userArticleId;
    newDebtArticle.userId = user;
    newDebtArticle.articleId = data.articleId;
    newDebtArticle.value = value;
    newDebtArticle.serialNumber = data.serialNumber;
    newDebtArticle.comment = data.comment;
    newDebtArticle.status = 'razduženo';
    newDebtArticle.documentId = savedDocument.documentsId;
    newDebtArticle.invBroj = data.invBroj;

    const savedArticleInDebtItems = await this.debtItems.save(newDebtArticle);

    if (!savedArticleInDebtItems) {
      return new ApiResponse('error', -2006, 'Artikal nije zadužen na radnika');
    }

    /* Nakon evidencije artikla u UserArticle potrebno uraditi izmjenu i u 
    tabeli skladišta, gdje nakon razduženja artikla, artikal treba biti 
    ponovo na stanju */
    const articleInStock: Stock = await this.stock.findOne({
      articleId: data.articleId,
    });
    await this.stock.remove(articleInStock);
    const newArticleStock: Stock = await new Stock();
    newArticleStock.articleId = data.articleId;
    newArticleStock.valueOnConcract = articleInStock.valueOnConcract;
    newArticleStock.valueAvailable = articleInStock.valueAvailable + value;
    newArticleStock.sapNumber = articleInStock.sapNumber;
    /* Potrebno dodati hvatanje greške */
    const savedStockArticle = await this.stock.save(newArticleStock);
    if (!savedStockArticle) {
      return new ApiResponse('error', -2010, 'Artikal nije spašen u skladište');
    }

    return await this.debtItems.findOne({
      where: { articleId: data.articleId },
      relations: ['article', 'user', 'userArticle'],
    });
  }
} /* KRAJ KODA */

/* Iz razloga što ne brišem iz userArticle stanje zaduženog artikla, dolazi do zabune u aplikaciji, gdje se dešava da sam artikal koji je bio
zadužen na radnik, razdužio ga, ali ostao je u evidenciji userArticle sa statusom zadužen, i samim tim funkciju otpisivanja ne radi kako treba, 
jer u tom trenutku trenutni artikal nije ustvari zadužen (otpisan je već ranije ali stoji u evidenciji), i kada se pokrene fukncija otpisivanja,
ona ustvari otpiše, već razduženi artikal sa korisnika. Da bi se sve to izbjeglo, potrebno je ipak izvršiti evidenciju razdužena i otpisivanja u posebnim tabelama DONE */

/* Uraditi funkcije da se rastereti kod, i malo reorganizuje jer ima kodova koji se ponavljaju */
