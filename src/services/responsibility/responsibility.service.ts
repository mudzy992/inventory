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
import { Docxtemplater } from 'docxtemplater'


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
  ) {
    super(responsibility);
  }
  async addArticleToEmploye(
    userId: number,
    data: AddEmployeArticleDto,
  ): Promise<User | Stock | Responsibility | UserArticle | ApiResponse> {
    /* Provjera ako korisnik već ima zadužen artikal pod articleId i userId i userArticle DONE*/
    /* Provjera da li na stanju više ima artikala da se zaduži DONE */
    /* Implementacija mehanizma za automacko umanjenje količine na skladištu DONE*/
    /* Implementacija vraćanja artikla iz zaduženo u na skladištu, uvećavanje (pogledati bazu, podataka zaduženja u userArticles) 
    promjeniti u bazi na stockArticles i stock postaviti status, te ako je u dto status razduzeno izvrsiti + onoliko koliko je zaduzeno bilo 
    te ga brisati iz stockArticles u stock koji ce imati za taj article status na stanju ili nema na stanju (promjeniti if statement za nema na stanju na osnov statusa) */
    /* vrsiti historija zaduzenja i razduzenja sa timestamp DONE */

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

    if (exResponsibility) {
      return new ApiResponse(
        'error',
        -2002,
        'Artikal sa traženim serijskim brojem je već zadužen.',
      );
    } else if (exDebt) {
      await this.debtItems.remove(exDebt);
      return this.addArticleInResponsibility(userId, data);
    } else if (exDestroyed) {
      return new ApiResponse(
        'error',
        -2007,
        'Artikal sa traženim serijskim brojem je već uništen.',
      );
    }

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
    this.addArticleInResponsibility(userId, data);
  }

  private async addArticleInResponsibility(
    user: number,
    data: AddEmployeArticleDto,
  ) {
    const generateDocument = () => {
      loadFile(
          prenosnica,
          function (error: any, content: PizZip.LoadData) {
              if (error) {
                  throw error;
              }
              const zip = new PizZip(content);
              const doc = new Docxtemplater(zip, {
                  paragraphLoop: true,
                  linebreaks: true,
              });

              // render the document (replace all occurences of {first_name} by John, {last_name} by Doe, ...)
              doc.render({
                  id_prenosnice: 2514549,
                  predao_korisnik: "Skladište",
                  preuzeo_korisnik: korisnik_preuzeo,
                  inventurni_broj: serialNumber,
                  naziv_opreme: article_name,
                  komentar: komentar,
              });
              const out = doc.getZip().generate({
                  type: "blob",
                  mimeType:
                      "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
              }); //Output the document using Data-URI
              saveAs(out, "output" + "15" +  ".docx");
          }
      );
  }

    const newDocument: Documents = new Documents();
    newDocument.path ="/prenosnica.docx"

    const savedDocument = await this.document.save(newDocument);
    if (!savedDocument) {
      return new ApiResponse(
        'error',
        -2020,
        'Prenosnica nije kreirana',
      );
    }

    const newUserArticleData: UserArticle = new UserArticle();
    newUserArticleData.documentId = savedDocument.documentsId;
    newUserArticleData.userId = user;
    newUserArticleData.serialNumber = data.serialNumber;
    newUserArticleData.articleId = data.articleId;
    newUserArticleData.comment = data.comment;
    newUserArticleData.status = 'zaduženo';

    const savedUserArticle = await this.userArticle.save(newUserArticleData);
    if (!savedUserArticle) {
      return new ApiResponse(
        'error',
        -2021,
        'User Article ne može biti kreiran', /* Iako do ove greške teško da će doći */
      );
    }

    const newArticleOnUser: Responsibility = new Responsibility();
    newArticleOnUser.userArticleId = savedUserArticle.userArticleId;
    newArticleOnUser.userId = user;
    newArticleOnUser.articleId = data.articleId;
    newArticleOnUser.value = data.value;
    newArticleOnUser.status = 'zaduženo';
    newArticleOnUser.serialNumber = data.serialNumber;

    const savedNewResponsibility = await this.responsibility.save(
      newArticleOnUser,
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
