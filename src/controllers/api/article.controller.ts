import {
  Body,
  Controller,
  Get,
  Param,
  Patch,
  Post,
  Query,
  UseGuards,
} from "@nestjs/common";
import { Crud } from "@nestjsx/crud";
import { AddArticleDto } from "src/dtos/article/add.article.dto";
import { EditArticleDto } from "src/dtos/article/edit.full.article.dto";
import { Article } from "src/entities/Article";
import { AllowToRoles } from "src/misc/allow.to.roles.descriptor";
import { ApiResponse } from "src/misc/api.response.class";
import { RoleCheckedGuard } from "src/misc/role.checker.guard";
import { ArticleService } from "src/services/article/article.service";

@Controller("api/article")
@Crud({
  model: {
    type: Article,
  },
  params: {
    id: {
      field: "articleId",
      type: "number",
      primary: true,
    },
  },
  query: {
    join: {
      user: {
        eager: true,
        exclude: ["passwordHash"],
      },
      stock: {
        eager: true,
      },
      category: {
        eager: true,
      },
      stockFeatures: {
        eager: true,
      },
      articleTimelines: {
        eager: true,
      },
      documents: {
        eager: false,
      },
      upgradeFeatures: {
        eager: false,
      },
    },
  },
  routes: { exclude: ["updateOneBase"] },
})
export class ArticleController {
  constructor(public service: ArticleService) {}
  @Post(":stockId")
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles("administrator", "moderator")
  async addNewArticle(
    @Param("stockId") id: number,
    @Body() data: AddArticleDto
  ): Promise<Article | ApiResponse> {
    return await this.service.addNewArticle(id, data);
  }

  /* Ovoj ruti imaju pristup svi i obični korisnik, administrator, moderator */
  @Get("/user/:userId")
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles("administrator", "moderator", "user")
  getById(
    @Param("userId") userId: number
  ): Promise<Article[] | ApiResponse> {
    return new Promise(async (resolve) => {
      const articleByUserId = await this.service.getByUserId(userId);
      if (articleByUserId === undefined) {
        resolve(new ApiResponse("error", -8002));
      }
      resolve(articleByUserId);
    });
  }

  @Get("s/:stockId")
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles("administrator", "moderator")
  async articleSearchPaginationByStockId(
    @Param("stockId") stockId: number,
    @Query("perPage") perPage: number = 10,
    @Query("page") page: number = 1,
    @Query("query") query: string = ""
  ) {
    const offset = (page - 1) * perPage;
    return this.service.articleSearchPaginationByStockId(
      stockId,
      perPage,
      offset,
      query
    );
  }

  /* Ovoj ruti imaju pristup svi */
  @Get("sb/:serialNumber")
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles("user", "administrator", "moderator")
  async getBySerialNumber(@Param("serialNumber") serialNumber: string) {
    return this.service.getBySerialNumber(serialNumber);
  }

  @Patch("status/:id")
  async changeStatus(@Param("id") id: number, @Body() data: AddArticleDto) {
    return await this.service.changeStatus(id, data);
  }

  // @Patch(':id')
  // async editFullArticleController(
  //   @Param('id') id: number,
  //   @Body() data: EditArticleDto,
  // ) {
  //   return await this.service.editArticle(id, data);
  // }

  // @Patch('/stock/:id')
  // async changeStockExistArticle(
  //   @Param('id') id: number,
  //   @Body() data: AddArticleDto,
  // ) {
  //   return await this.service.changeStockExistArticle(id, data);
  // }
} /* Kraj koda */
