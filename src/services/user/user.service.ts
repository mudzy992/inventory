import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { TypeOrmCrudService } from '@nestjsx/crud-typeorm';
import { AddEmployeArticleDto } from 'src/dtos/user/add.employe.article.dto';
import { AddNewEmployeDto } from 'src/dtos/user/add.new.employe.dto';
import { Stock } from 'src/entities/Stock';
import { User } from 'src/entities/User';
import { UserArticle } from 'src/entities/UserArticle';
import { ApiResponse } from 'src/misc/api.response.class';
import { Repository } from 'typeorm';

@Injectable()
export class UserService extends TypeOrmCrudService<User> {
  constructor(
    @InjectRepository(User)
    private readonly user: Repository<User>, //Čim spomenenom neki repozitorijum moramo da taj repozitoriju evidentiramo u našem osnovnom modulu (app.module.ts)
    @InjectRepository(UserArticle)
    private readonly userArticle: Repository<UserArticle>,
    @InjectRepository(Stock)
    private readonly stock: Repository<Stock>,
  ) {
    super(user);
  }

  async createNewUser(data: AddNewEmployeDto): Promise<User | ApiResponse> {
    const newUser: User = new User();
    newUser.surname = data.surename;
    newUser.forname = data.forname;
    newUser.jobTitle = data.job;
    newUser.department = data.department;
    newUser.location = data.location;

    const savedUser = await this.user.save(newUser);
    if (!savedUser) {
      return new ApiResponse('error', -2001, 'Radnik ne može biti dodan');
    }

    return await this.findOne(savedUser.userId, {
      relations: ['userArticles'],
    });
  }

  /* IZMJENA DETALJA RADNIKA MEHANIZAM - implementirati */

  async getByEmail(email: string): Promise<User | null> {
    /* Mehanizam pronalaženja artikla u skladištu po sap broju */
    const user = await this.user.findOne({ surname: email });
    if (user) {
      return user;
    }
    return null;
  }

  async addEmployeArticle(
    userId: number,
    data: AddEmployeArticleDto,
  ): Promise<User | ApiResponse> {
    /* Provjera ako korisnik već ima zadužen artikal pod articleId i userId i userArticle DONE*/
    /* Provjera da li na stanju više ima artikala da se zaduži DONE */
    /* Implementacija mehanizma za automacko umanjenje količine na skladištu DONE*/
    /* Implementacija vraćanja artikla iz zaduženo u na skladištu, uvećavanje (pogledati bazu, podataka zaduženja u userArticles) */

    const user: User = await this.user.findOne({ userId: userId });

    const articleID = data.articleId;
    const existingArticleOnUser: UserArticle = await this.userArticle.findOne({
      userId: userId,
      articleId: articleID,
    });

    console.log(existingArticleOnUser);
    if (!existingArticleOnUser === undefined) {
      return new ApiResponse(
        'error',
        -2004,
        'Artikal ne može biti dodan za tog radnika, provjeri podatke i pokušaj ponovo',
      );
    }

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

    const savedUserArticle = await this.userArticle.save(newArticleOnUser);

    if (!savedUserArticle) {
      return new ApiResponse(
        'error',
        -2003,
        'Artikal ne može biti zadužen za tog radnika',
      );
    }

    const articleInStock = await this.stock.findOne({
      articleId: articleID,
    });

    if (articleInStock) {
      if (articleInStock.valueAvailable === 0) {
        return new ApiResponse(
          'error',
          -2005,
          'Na stanju više nema traženog artikla',
        );
      }
      const valueOnConcract = articleInStock.valueOnConcract;
      const valueAvailable = articleInStock.valueAvailable;
      const sapNumber = articleInStock.sapNumber;

      await this.stock.remove(articleInStock);
      const newArticleStock: Stock = new Stock();
      newArticleStock.articleId = articleID;
      newArticleStock.valueOnConcract = valueOnConcract;
      newArticleStock.valueAvailable = valueAvailable - savedUserArticle.value;
      newArticleStock.sapNumber = sapNumber;
      await this.stock.save(newArticleStock);
    }
  }
} /* KRAJ KODA */
