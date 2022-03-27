import { MiddlewareConsumer, Module, NestModule } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { DatabaseConfiguration } from 'config/database.configuration';
import { Article } from 'src/entities/Article';
import { ArticleService } from 'src/services/article/article.service';
import { ArticleFeature } from 'src/entities/ArticleFeature';
import { Category } from 'src/entities/Category';
import { Destroyed } from 'src/entities/Destroyed';
import { Feature } from 'src/entities/Feature';
import { Stock } from 'src/entities/Stock';
import { User } from 'src/entities/User';
import { Responsibility } from 'src/entities/Responsibility';
import { ArticleController } from './controllers/api/article.controller';
import { UserService } from './services/user/user.service';
import { UserController } from './controllers/api/user.controller';
import { CategoryService } from './services/category/category.service';
import { CategoryController } from './controllers/api/category.controller';
import { StockService } from './services/stock/stock.service';
import { StockController } from './controllers/api/stock.controller';
import { FeatureService } from './services/feature/feature.service';
import { FeatureController } from './controllers/api/feature.controller';
import { ResponsibilityController } from './controllers/api/responsibility.controller';
import { ResponsibilityService } from './services/responsibility/responsibility.service';
import { DebtItems } from './entities/DebtItems';
import { DebtItemsService } from './services/debtItems/debt.items.service';
import { DebtItemsController } from './controllers/api/debt.controller';
import { DestroyedArticlesService } from './services/destroyed/destroyed.articles.service';
import { DestroyedArticlesController } from './controllers/api/destroyed.controller';
import { UserArticleController } from './controllers/api/user.article.controller';
import { UserArticleService } from './services/userArticle/user.article.service';
import { UserArticle } from './entities/UserArticle';
import { AdministratorService } from './services/administrator/administrator.service';
import { Administrator } from './entities/Administrator';
import { AdministratorController } from './controllers/api/administrator.controller';
import { AuthMiddleware } from './middlewares/auth.middleware';
import { UserToken } from './entities/UserToken';
import { AdministratorToken } from './entities/AdministratorToken';
import { AuthController } from './controllers/api/auth.controller';
import { Documents } from './entities/Documents';
import { DocumentService } from './services/document/document.service';
import { DocumentController } from './controllers/api/document.controller';

@Module({
  imports: [
    TypeOrmModule.forRoot({
      type: 'mysql',
      host: DatabaseConfiguration.hostname,
      username: DatabaseConfiguration.username,
      password: DatabaseConfiguration.password,
      database: DatabaseConfiguration.database,
      entities: [
        Article,
        ArticleFeature,
        Category,
        Destroyed,
        Feature,
        Stock,
        User,
        Responsibility,
        DebtItems,
        UserArticle,
        Administrator,
        UserToken,
        AdministratorToken,
        Documents,
      ],
    }),
    TypeOrmModule.forFeature([
      Article,
      ArticleFeature,
      Category,
      Destroyed,
      Feature,
      Stock,
      User,
      Responsibility,
      DebtItems,
      UserArticle,
      Administrator,
      UserToken,
      AdministratorToken,
      Documents,
    ]),
  ],
  controllers: [
    ArticleController,
    UserController,
    CategoryController,
    StockController,
    FeatureController,
    ResponsibilityController,
    DebtItemsController,
    DestroyedArticlesController,
    UserArticleController,
    AdministratorController,
    AuthController,
    DocumentController,
  ],
  providers: [
    ArticleService,
    UserService,
    CategoryService,
    StockService,
    FeatureService,
    ResponsibilityService,
    DebtItemsService,
    DestroyedArticlesService,
    UserArticleService,
    AdministratorService,
    UserService,
    DocumentService,
  ],
  exports: [
    // zbog middleware potrebno je exportovati servis
    // da bi svi ostali elementi koji se nalaze van okvira modula
    AdministratorService,
    UserService,
  ],
})
export class AppModule implements NestModule {
  configure(consumer: MiddlewareConsumer) {
    // Nema throw već mi treba da odredimo šta treba da radi
    // a mi želimo da on primjeni određeni middleware
    consumer
      .apply(AuthMiddleware)
      // kada kažemo koji middleware naš konzumer treba da primjenjuje
      // moramo da damo nekoliko izuzetaka, i spisak ruta za koje će važiti
      .exclude('auth/*') // Izbjegni sve što počinje sa auth/*, 'assets/*', 'uploads/*'itd.
      .forRoutes('api/*'); // Ali primjeni se na sve što počinje sa api/
  }
}
