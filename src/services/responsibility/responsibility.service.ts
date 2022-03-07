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
  ) {
    super(responsibility);
  }
  async addArticleToEmploye(
    userId: number,
    data: AddEmployeArticleDto,
  ): Promise<User | Stock | Responsibility | ApiResponse> {
    /* Provjera ako korisnik već ima zadužen artikal pod articleId i userId i userArticle DONE*/
    /* Provjera da li na stanju više ima artikala da se zaduži DONE */
    /* Implementacija mehanizma za automacko umanjenje količine na skladištu DONE*/
    /* Implementacija vraćanja artikla iz zaduženo u na skladištu, uvećavanje (pogledati bazu, podataka zaduženja u userArticles) 
    promjeniti u bazi na stockArticles i stock postaviti status, te ako je u dto status razduzeno izvrsiti + onoliko koliko je zaduzeno bilo 
    te ga brisati iz stockArticles u stock koji ce imati za taj article status na stanju ili nema na stanju (promjeniti if statement za nema na stanju na osnov statusa) */
    /* vrsiti historija zaduzenja i razduzenja sa timestamp DONE */
    /*  */

    const existingArticleOnUser: Responsibility = await this.findOne({
      userId: userId,
      articleId: data.articleId,
      status: 'zaduženo',
      serialNumber: data.serialNumber,
    });

    /* Neispravni podaci */
    if (!existingArticleOnUser === undefined) {
      return new ApiResponse(
        'error',
        -2002,
        'Artikal sa traženim serijskim brojem je već zadužen.',
      );
    }

    const existinArticleDebt: DebtItems = await this.debtItems.findOne({
      serialNumber: data.serialNumber,
    });

    if (existinArticleDebt) {
      return new ApiResponse(
        'error',
        -2008,
        'Artikal sa traženim serijskim brojem je već razdužen.',
      );
    }

    const existinArticleDestroyed: Destroyed = await this.destroyed.findOne({
      serialNumber: data.serialNumber,
    });

    if (existinArticleDestroyed) {
      return new ApiResponse(
        'error',
        -2007,
        'Artikal sa traženim serijskim brojem je već uništen.',
      );
    }

    const newArticleOnUser: Responsibility = new Responsibility();
    newArticleOnUser.userId = userId;
    newArticleOnUser.articleId = data.articleId;
    newArticleOnUser.value = data.value;
    newArticleOnUser.status = 'zaduženo';
    newArticleOnUser.serialNumber = data.serialNumber;

    const savedNewResponsibility = await this.responsibility.save(newArticleOnUser);

    if (!savedNewResponsibility) {
      return new ApiResponse(
        'error',
        -2003,
        'Artikal ne može biti zadužen za tog radnika',
      );
    }

    const newUserArticleData: UserArticle = new UserArticle();

    newUserArticleData.responsibilityId = savedNewResponsibility.responsibilityId;
    newUserArticleData.userId = userId;
    newUserArticleData.serialNumber = data.serialNumber;

    await this.userArticle.save(newUserArticleData);
    
    /* Provjera ako artikla nema na stanju više na skladištu da se zaduži, i ako ima skini određeni broj */
    const articleInStock: Stock = await this.stock.findOne({
      articleId: data.articleId,
    });

    if (articleInStock) {
      if (articleInStock.valueAvailable === 0) {
        return new ApiResponse(
          'error',
          -2005,
          'Na stanju više nema traženog artikla',
        );
      }

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
    }
  /* FUNKCIJE */
} /* KRAJ KODA */
}
/* Iz razloga što ne brišem iz userArticle stanje zaduženog artikla, dolazi do zabune u aplikaciji, gdje se dešava da sam artikal koji je bio
zadužen na radnik, razdužio ga, ali ostao je u evidenciji userArticle sa statusom zadužen, i samim tim funkciju otpisivanja ne radi kako treba, 
jer u tom trenutku trenutni artikal nije ustvari zadužen (otpisan je već ranije ali stoji u evidenciji), i kada se pokrene fukncija otpisivanja,
ona ustvari otpiše, već razduženi artikal sa korisnika. Da bi se sve to izbjeglo, potrebno je ipak izvršiti evidenciju razdužena i otpisivanja u posebnim tabelama DONE

Uraditi funkcije da se rastereti kod, i malo reorganizuje jer ima kodova koji se ponavljaju */