import {
  ClassSerializerInterceptor,
  Controller,
  Get,
  Param,
  Query,
  UseGuards,
  UseInterceptors,
} from "@nestjs/common";
import { Crud } from "@nestjsx/crud";
import { ArticleTimelineDTO } from "src/dtos/article.timeline/article.timeline.dto";
import { ArticleTimeline } from "src/entities/ArticleTimeline";
import { AllowToRoles } from "src/misc/allow.to.roles.descriptor";
import { ApiResponse } from "src/misc/api.response.class";
import { RoleCheckedGuard } from "src/misc/role.checker.guard";
import { ArticleTimelineService } from "src/services/articleTimeline/article.timeline.service";
import ArticleTimelineType from "src/types/article.timeline.type";
import PaginatedArticleTimelineType from "src/types/paggined.article.timeline.type";

@Controller("api/articleTimeline")
@Crud({
  model: {
    type: ArticleTimeline,
  },
  params: {
    id: {
      field: "articleTimelineId",
      type: "number",
      primary: true,
    },
  },
  query: {
    join: {
      article: {
        eager: true,
      },
      document: {
        eager: true,
      },
    },
  },
})
export class ArticleTimelineController {
  constructor(public articleTimelineService: ArticleTimelineService) {}

  @Get(":id")
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles("administrator", "moderator")
  async getById(@Param("id") id: string): Promise<ArticleTimelineDTO | ApiResponse> {
    return await this.articleTimelineService.getById(id)
  }

  @Get()
  @UseInterceptors(ClassSerializerInterceptor)
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles("administrator", "moderator")
  async getAll() {
    const articles = await this.articleTimelineService.getAll();
    const mappedArticles = articles.map((article) => ({
      ...article,
      user: { ...article.user, passwordHash: undefined },
      subbmited: { ...article.subbmited, passwordHash: undefined },
    }));
    return mappedArticles;
  }

  @Get("p/:id")
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles("administrator", "moderator")
  async findPaginatedArticlesTimeline(
    @Param("id") id: number,
    @Query("perPage") perPage: number = 10,
    @Query("offset") offset: number = 0
  ) {
    const articles: PaginatedArticleTimelineType =
      await this.articleTimelineService.findPaginatedArticlesTimeline(
        id,
        perPage,
        offset
      );
    return articles.results.map((article) =>
      this.articleWithoutPasswordHash(article)
    );
  }

  private articleWithoutPasswordHash(
    article: ArticleTimelineType
  ): ArticleTimelineType {
    return {
      ...article,
      user: { ...article.user, passwordHash: undefined },
      subbmited: { ...article.subbmited, passwordHash: undefined },
    };
  }
}
