import { MiddlewareConsumer, Module, NestModule } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { DatabaseConfiguration } from 'config/database.configuration';
import { Article } from 'src/entities1/Article';
import { ArticleService } from 'src/services/article/article.service';
import { ArticleFeature } from 'src/entities1/ArticleFeature';
import { Category } from 'src/entities1/Category';
import { Destroyed } from 'src/entities1/Destroyed';
import { Feature } from 'src/entities1/Feature';
import { Stock } from 'src/entities1/Stock';
import { User } from 'src/entities1/User';
import { Responsibility } from 'src/entities1/Responsibility';
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
import { DebtItems } from './entities1/DebtItems';
import { DebtItemsService } from './services/debtItems/debt.items.service';
import { DebtItemsController } from './controllers/api/debt.controller';
import { DestroyedArticlesService } from './services/destroyed/destroyed.articles.service';
import { DestroyedArticlesController } from './controllers/api/destroyed.controller';
import { UserArticleController } from './controllers/api/user.article.controller';
import { UserArticleService } from './services/userArticle/user.article.service';
import { UserArticle } from './entities1/UserArticle';
import { AdministratorService } from './services/administrator/administrator.service';
import { Administrator } from './entities1/Administrator';
import { AdministratorController } from './controllers/api/administrator.controller';
import { AuthMiddleware } from './middlewares/auth.middleware';
import { UserToken } from './entities1/UserToken';
import { AdministratorToken } from './entities1/AdministratorToken';
import { AuthController } from './controllers/api/auth.controller';
import { Documents } from './entities1/Documents';
import { DocumentService } from './services/document/document.service';
import { DocumentController } from './controllers/api/document.controller';
import { UpgradeFeature } from './entities1/UpgradeFeature';
import { UpgradeFeatureService } from './services/upgradeFeature/upgrade.features.service';
import { UpgradeFeatureController } from './controllers/api/upgrade.feature.controller';
import { Department } from './entities1/Department';
import { DepartmentJob } from './entities1/DepartmentJob';
import { Job } from './entities1/Job';
import { Location } from './entities1/Location';
import { DepartmentController } from './controllers/api/department.controller';
import { DepartmentService } from './services/department/department.service';
import { JobController } from './controllers/api/job.controller';
import { JobService } from './services/job/job.service';
import { LocationController } from './controllers/api/location.controller';
import { LocationService } from './services/location/location.service';
import { DepartmentJobController } from './controllers/api/department.job.controller';
import { DepartmentJobService } from './services/departmentJob/department.job.service';
import { ArticleTimeline } from './entities1/ArticleTimeline';
import { ArticleTimelineController } from './controllers/api/article.timeline.controller';
import { ArticleTimelineService } from './services/articleTimeline/article.timeline.service';
import { WebhookController } from './controllers/api/web.hook.controller';
import { SkipAuthMiddleware } from './middlewares/skip.auth.middleware';
import { WebhookFrontendController } from './controllers/api/web.hook.frontend.controller';

@Module({
  imports: [
    TypeOrmModule.forRoot({
      type: 'mysql',
      host: DatabaseConfiguration.hostname,
      port: DatabaseConfiguration.port,
      username: DatabaseConfiguration.username,
      password: DatabaseConfiguration.password,
      database: DatabaseConfiguration.database,
      
      entities: [
        Article,
        ArticleTimeline,
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
        UpgradeFeature,
        Department,
        DepartmentJob,
        Job,
        Location,
      ],
    }),
    TypeOrmModule.forFeature([
      Article,
      ArticleFeature,
      ArticleTimeline,
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
      UpgradeFeature,
      Department,
      DepartmentJob,
      Job,
      Location,
    ]),
  ],
  controllers: [
    ArticleController,
    ArticleTimelineController,
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
    UpgradeFeatureController,
    DepartmentController,
    JobController,
    LocationController,
    DepartmentJobController,
    WebhookController,
    WebhookFrontendController,
  ],
  providers: [
    ArticleService,
    ArticleTimelineService,
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
    UpgradeFeatureService,
    DepartmentService,
    JobService,
    LocationService,
    DepartmentJobService,
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
      .apply(AuthMiddleware, SkipAuthMiddleware)
      // kada kažemo koji middleware naš konzumer treba da primjenjuje
      // moramo da damo nekoliko izuzetaka, i spisak ruta za koje će važiti
      .exclude('auth/*') // Izbjegni sve što počinje sa auth/*, 'assets/*', 'uploads/*'itd.
      .forRoutes('api/*'); // Ali primjeni se na sve što počinje sa api/
  }
}
