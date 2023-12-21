import { MiddlewareConsumer, Module, NestModule } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { DatabaseConfiguration } from 'config/database.configuration';
import { Article } from 'src/entities/Article';
import { ArticleService } from 'src/services/article/article.service';
import { StockFeature } from 'src/entities/StockFeature';
import { Category } from 'src/entities/Category';
import { Feature } from 'src/entities/Feature';
import { Stock } from 'src/entities/Stock';
import { User } from 'src/entities/User';
import { ArticleController } from './controllers/api/article.controller';
import { UserService } from './services/user/user.service';
import { UserController } from './controllers/api/user.controller';
import { CategoryService } from './services/category/category.service';
import { CategoryController } from './controllers/api/category.controller';
import { StockService } from './services/stock/stock.service';
import { StockController } from './controllers/api/stock.controller';
import { FeatureService } from './services/feature/feature.service';
import { FeatureController } from './controllers/api/feature.controller';
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
import { UpgradeFeature } from './entities/UpgradeFeature';
import { UpgradeFeatureService } from './services/upgradeFeature/upgrade.features.service';
import { UpgradeFeatureController } from './controllers/api/upgrade.feature.controller';
import { Department } from './entities/Department';
import { DepartmentJob } from './entities/DepartmentJob';
import { Job } from './entities/Job';
import { Location } from './entities/Location';
import { DepartmentController } from './controllers/api/department.controller';
import { DepartmentService } from './services/department/department.service';
import { JobController } from './controllers/api/job.controller';
import { JobService } from './services/job/job.service';
import { LocationController } from './controllers/api/location.controller';
import { LocationService } from './services/location/location.service';
import { DepartmentJobController } from './controllers/api/department.job.controller';
import { DepartmentJobService } from './services/departmentJob/department.job.service';
import { ArticleTimeline } from './entities/ArticleTimeline';
import { ArticleTimelineController } from './controllers/api/article.timeline.controller';
import { ArticleTimelineService } from './services/articleTimeline/article.timeline.service';
import { WebhookController } from './controllers/api/web.hook.controller';
import { SkipAuthMiddleware } from './middlewares/skip.auth.middleware';
import { WebhookFrontendController } from './controllers/api/web.hook.frontend.controller';
import { AdministratorDashboardController } from './controllers/api/administrator.dashboard.controller';
import { AdministratorDashboardService } from './services/administrator.dashboard/administrator.dashboard.service';
import { UserRole } from './entities/UserRole';

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
        StockFeature,
        Category,
        Feature,
        Stock,
        User,
        Administrator,
        UserToken,
        AdministratorToken,
        Documents,
        UpgradeFeature,
        Department,
        DepartmentJob,
        Job,
        Location,
        UserRole,
      ],
    }),
    TypeOrmModule.forFeature([
      Article,
      StockFeature,
      ArticleTimeline,
      Category,
      Feature,
      Stock,
      User,
      Administrator,
      UserToken,
      AdministratorToken,
      Documents,
      UpgradeFeature,
      Department,
      DepartmentJob,
      Job,
      Location,
      UserRole,
    ]),
  ],
  controllers: [
    ArticleController,
    ArticleTimelineController,
    UserController,
    CategoryController,
    StockController,
    FeatureController,
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
    AdministratorDashboardController,
  ],
  providers: [
    ArticleService,
    ArticleTimelineService,
    UserService,
    CategoryService,
    StockService,
    FeatureService,
    AdministratorService,
    UserService,
    DocumentService,
    UpgradeFeatureService,
    DepartmentService,
    JobService,
    LocationService,
    DepartmentJobService,
    AdministratorDashboardService,
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
