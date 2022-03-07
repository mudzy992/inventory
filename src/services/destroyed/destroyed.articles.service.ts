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

@Injectable()
export class DestroyedArticlesService extends TypeOrmCrudService<Destroyed> {
  constructor(
    @InjectRepository(Destroyed)
    private readonly destroyed: Repository<Destroyed>,
    @InjectRepository(Responsibility)
    private readonly responsibility: Repository<Responsibility>,
    @InjectRepository(Stock)
    private readonly stock: Repository<Stock>,
    @InjectRepository(DebtItems)
    private readonly debtItems: Repository<DebtItems>,
    @InjectRepository(User)
    private readonly user: Repository<User>,
    @InjectRepository(UserArticle)
    private readonly userArticle: Repository<UserArticle>,
  ) {
    super(destroyed);
  }
  async addArticleToEmploye(
    userId: number,
    data: AddEmployeArticleDto,
  ): Promise<Destroyed | Stock | Responsibility | ApiResponse> {
    /* Provjera ako korisnik već ima zadužen artikal pod articleId i userId i userArticle DONE*/
    /* Provjera da li na stanju više ima artikala da se zaduži DONE */
    /* Implementacija mehanizma za automacko umanjenje količine na skladištu DONE*/
    /* Implementacija vraćanja artikla iz zaduženo u na skladištu, uvećavanje (pogledati bazu, podataka zaduženja u userArticles) 
    promjeniti u bazi na stockArticles i stock postaviti status, te ako je u dto status razduzeno izvrsiti + onoliko koliko je zaduzeno bilo 
    te ga brisati iz stockArticles u stock koji ce imati za taj article status na stanju ili nema na stanju (promjeniti if statement za nema na stanju na osnov statusa) */
    /* vrsiti historija zaduzenja i razduzenja sa timestamp DONE */
    /*  */
    let value = 0;
    const existinArticleDestroyed: Destroyed = await this.findOne({
      serialNumber: data.serialNumber,
    });

    if (existinArticleDestroyed) {
      return new ApiResponse(
        'error',
        -2006,
        'Artikal sa traženim serijskim brojem je već uništen.',
      );
    }
    
    const existingResponsibilityArticleOnUser: Responsibility =
      await this.responsibility.findOne({
        userId: userId,
        status: 'zaduženo',
        articleId: data.articleId,
        serialNumber: data.serialNumber,
      });

      if (existingResponsibilityArticleOnUser) {
        value = existingResponsibilityArticleOnUser.value
        await this.responsibility.remove(existingResponsibilityArticleOnUser);
      } 
    
    const existingArticleInUserArticle: UserArticle =
          await this.userArticle.findOne({
            serialNumber: data.serialNumber,
          });
    if (existingArticleInUserArticle) {
      await this.userArticle.remove(existingArticleInUserArticle);
    } 

    const existinArticleDebt: DebtItems = await this.debtItems.findOne({
      serialNumber: data.serialNumber,
    });

    if(existinArticleDebt) {
      value = existinArticleDebt.value
      await this.debtItems.remove(existinArticleDebt);
    }

    const destroyedArticle: Destroyed = new Destroyed();
    destroyedArticle.userId = userId;
    destroyedArticle.articleId = data.articleId;
    destroyedArticle.value = value;
    destroyedArticle.serialNumber = data.serialNumber;
    destroyedArticle.comment = data.comment;
    destroyedArticle.status = 'otpisano';

    const saveDestroyedArticle = await this.destroyed.save(destroyedArticle);

    if (!saveDestroyedArticle) {
      return new ApiResponse(
        'error',
        -2003,
        'Artikal ne može biti zadužen za tog radnika',
      );
    }

    const newUserArticleData: UserArticle = new UserArticle();

    newUserArticleData.destroyId = saveDestroyedArticle.destroyedId;
    newUserArticleData.userId = userId;
    newUserArticleData.serialNumber = data.serialNumber;

    const savedUserArticle = await this.userArticle.save(newUserArticleData);

    if (!savedUserArticle) {
      return new ApiResponse('error', -2006, 'Artikal nije zadužen na radnika');
    }
    return await this.destroyed.findOne({
      where: {articleId : data.articleId},
      relations: ['article', 'user'],
    });
  }
  /* FUNKCIJE */
}
