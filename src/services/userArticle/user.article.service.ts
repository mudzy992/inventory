import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { TypeOrmCrudService } from '@nestjsx/crud-typeorm';
import { AddEmployeArticleDto } from 'src/dtos/user/add.employe.article.dto';
import { Stock } from 'src/entities/Stock';
import { UserArticle } from 'src/entities/UserArticle';
import { ApiResponse } from 'src/misc/api.response.class';
import { Repository } from 'typeorm';

@Injectable()
export class UserArticleService extends TypeOrmCrudService<UserArticle> {
  constructor(
    @InjectRepository(UserArticle)
    private readonly userArticle: Repository<UserArticle>,
    @InjectRepository(Stock)
    private readonly stock: Repository<Stock>,
  ) {
    super(userArticle);
  }
  async addArticleToEmploye(
    userId: number,
    data: AddEmployeArticleDto,
  ): Promise<Stock | UserArticle | ApiResponse> {
    /* Provjera ako korisnik već ima zadužen artikal pod articleId i userId i userArticle DONE*/
    /* Provjera da li na stanju više ima artikala da se zaduži DONE */
    /* Implementacija mehanizma za automacko umanjenje količine na skladištu DONE*/
    /* Implementacija vraćanja artikla iz zaduženo u na skladištu, uvećavanje (pogledati bazu, podataka zaduženja u userArticles) 
    promjeniti u bazi na stockArticles i stock postaviti status, te ako je u dto status razduzeno izvrsiti + onoliko koliko je zaduzeno bilo 
    te ga brisati iz stockArticles u stock koji ce imati za taj article status na stanju ili nema na stanju (promjeniti if statement za nema na stanju na osnov statusa) */
    /* vrsiti historija zaduzenja i razduzenja sa timestamp DONE */
    /*  */

    const existingArticleOnUser: UserArticle = await this.findOne({
      userId: userId,
      articleId: data.articleId,
      status: data.status,
    });

    /* Neispravni podaci */
    if (!existingArticleOnUser === undefined) {
      return new ApiResponse(
        'error',
        -2004,
        'Artikal ne može biti dodan za tog radnika, provjeri podatke i pokušaj ponovo',
      );
    }

    if (data.status === 'zaduženo') {
      /* Provjera ako je već artikal zadužen za trenutnog radnika */
      if (existingArticleOnUser) {
        return new ApiResponse(
          'error',
          -2002,
          'Radnik je već zadužen za traženi artikal',
        );
      }

      const newArticleOnUser: UserArticle = new UserArticle();
      newArticleOnUser.userId = userId;
      newArticleOnUser.articleId = data.articleId;
      newArticleOnUser.value = data.value;
      newArticleOnUser.status = data.status;

      const savedUserArticle = await this.userArticle.save(newArticleOnUser);

      if (!savedUserArticle) {
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
          articleInStock.valueAvailable - savedUserArticle.value;
        newArticleStock.sapNumber = articleInStock.sapNumber;
        await this.stock.save(newArticleStock);

        return await this.userArticle.findOne({
          where: { articleId: data.articleId },
          relations: ['article', 'user'],
        });
      }
    }

    if (data.status === 'razduženo') {
      if (existingArticleOnUser) {
        return new ApiResponse(
          'error',
          -2006,
          'Artikal je već razdužen s radnika',
        );
      }

      const newArticleOnUser: UserArticle = new UserArticle();
      newArticleOnUser.userId = userId;
      newArticleOnUser.articleId = data.articleId;
      newArticleOnUser.value = data.value;
      newArticleOnUser.status = data.status;

      const savedUserArticle = await this.userArticle.save(newArticleOnUser);

      if (!savedUserArticle) {
        return new ApiResponse(
          'error',
          -2006,
          'Artikal je već razdužen s radnika',
        );
      }
      const existingResponsibilityArticleOnUser: UserArticle =
        await this.userArticle.findOne({
          userId: userId,
          articleId: data.articleId,
          status: 'zaduženo',
        });
      const articleInStock: Stock = await this.stock.findOne({
        articleId: data.articleId,
      });
      await this.stock.remove(articleInStock);
      const newArticleStock: Stock = await new Stock();
      newArticleStock.articleId = data.articleId;
      newArticleStock.valueOnConcract = articleInStock.valueOnConcract;
      newArticleStock.valueAvailable =
        articleInStock.valueAvailable +
        existingResponsibilityArticleOnUser.value;
      newArticleStock.sapNumber = articleInStock.sapNumber;
      await this.stock.save(newArticleStock);

      return newArticleStock;
    }

    if (data.status === 'otpisano') {
      if (existingArticleOnUser) {
        return new ApiResponse(
          'error',
          -2008,
          'Artikal je već otpisan sa radnika',
        );
      }
      const existingResponsibilityArticleOnUser: UserArticle =
        await this.userArticle.findOne({
          userId: userId,
          articleId: data.articleId,
          status: 'zaduženo',
        });
      await this.userArticle.remove(existingResponsibilityArticleOnUser);
      const newArticleOnUser: UserArticle = new UserArticle();
      newArticleOnUser.userId = userId;
      newArticleOnUser.articleId = data.articleId;
      newArticleOnUser.value = data.value;
      newArticleOnUser.status = data.status;

      const savedUserArticle = await this.userArticle.save(newArticleOnUser);

      if (!savedUserArticle) {
        return new ApiResponse(
          'error',
          -2003,
          'Artikal ne može biti zadužen za tog radnika',
        );
      }
    }
  }
} /* KRAJ KODA */

/* Iz razloga što ne brišem iz userArticle stanje zaduženog artikla, dolazi do zabune u aplikaciji, gdje se dešava da sam artikal koji je bio
zadužen na radnik, razdužio ga, ali ostao je u evidenciji userArticle sa statusom zadužen, i samim tim funkciju otpisivanja ne radi kako treba, 
jer u tom trenutku trenutni artikal nije ustvari zadužen (otpisan je već ranije ali stoji u evidenciji), i kada se pokrene fukncija otpisivanja,
ona ustvari otpiše, već razduženi artikal sa korisnika. Da bi se sve to izbjeglo, potrebno je ipak izvršiti evidenciju razdužena i otpisivanja u posebnim tabelama */

/* Uraditi funkcije da se rastereti kod, i malo reorganizuje jer ima kodova koji se ponavljaju */
