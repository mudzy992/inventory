import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { TypeOrmCrudService } from '@nestjsx/crud-typeorm';
import { AddEmployeArticleDto } from 'src/dtos/user/add.employe.article.dto';
import { DebtItems } from 'src/entities/DebtItems';
import { Destroyed } from 'src/entities/Destroyed';
import { Documents } from 'src/entities/Documents';
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
    @InjectRepository(Documents)
    private readonly document: Repository<Documents>,
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

    const existinArticleDestroyed: UserArticle = await this.userArticle.findOne(
      {
        serialNumber: data.serialNumber,
      },
    );
    /* Ako bi imao ikada potrebu da otpišem nešto što je na skladištu, ta provjera će ići ovdje, nešto slično kao što je u responsibility */
    if (!existinArticleDestroyed) {
      return new ApiResponse(
        'error',
        -2011,
        'Artikal sa traženim serijskim brojem ne postoji.',
      );
    }
    if (
      existinArticleDestroyed.serialNumber === data.serialNumber &&
      existinArticleDestroyed.status === 'otpisano'
    ) {
      return new ApiResponse(
        'error',
        -2002,
        'Artikal sa traženim serijskim brojem je već otpisan.',
      );
    } else if (
      existinArticleDestroyed.serialNumber === data.serialNumber &&
      existinArticleDestroyed.status === 'zaduženo'
    ) {
      return this.destroyArticle(userId, data);
    } else if (
      existinArticleDestroyed.serialNumber === data.serialNumber &&
      existinArticleDestroyed.status === 'razduženo'
    ) {
      return this.destroyArticle(userId, data);
    }
    return this.destroyArticle(userId, data);
  }
  /* FUNKCIJE */

  private async destroyArticle(user: number, data: AddEmployeArticleDto) {
    let value = 0;
    const existingResponsibilityArticleOnUser: Responsibility =
      await this.responsibility.findOne({
        userId: user,
        status: 'zaduženo',
        articleId: data.articleId,
        serialNumber: data.serialNumber,
      });

    if (existingResponsibilityArticleOnUser) {
      value = existingResponsibilityArticleOnUser.value;
      await this.responsibility.remove(existingResponsibilityArticleOnUser);
    }

    const existinArticleDebt: DebtItems = await this.debtItems.findOne({
      serialNumber: data.serialNumber,
    });

    if (existinArticleDebt) {
      value = existinArticleDebt.value;
      await this.debtItems.remove(existinArticleDebt);
    }

    const newDocument: Documents = new Documents();
    newDocument.path = '/prenosnica.docx';

    const savedDocument = await this.document.save(newDocument);
    if (!savedDocument) {
      return new ApiResponse('error', -2020, 'Prenosnica nije kreirana');
    }

    const newUserArticleData: UserArticle = new UserArticle();
    newUserArticleData.documentId = savedDocument.documentsId;
    newUserArticleData.articleId = data.articleId;
    newUserArticleData.userId = user;
    newUserArticleData.serialNumber = data.serialNumber;
    newUserArticleData.comment = data.comment;
    newUserArticleData.status = 'otpisano';

    const savedUserArticle = await this.userArticle.save(newUserArticleData);

    if (!savedUserArticle) {
      return new ApiResponse('error', -2006, 'Artikal nije zadužen na radnika');
    }

    const destroyedArticle: Destroyed = new Destroyed();
    destroyedArticle.userArticleId = savedUserArticle.userArticleId;
    destroyedArticle.userId = user;
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

    
    return await this.destroyed.findOne({
      where: { articleId: data.articleId },
      relations: ['article', 'user', 'userArticle'],
    });
  }
}
