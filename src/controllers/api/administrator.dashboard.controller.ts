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
import { Administrator } from "src/entities/Administrator";
import { Article } from "src/entities/Article";
import { Documents } from "src/entities/Documents";
import { Stock } from "src/entities/Stock";
import { AllowToRoles } from "src/misc/allow.to.roles.descriptor";
import { ApiResponse } from "src/misc/api.response.class";
import { RoleCheckedGuard } from "src/misc/role.checker.guard";
import { AdministratorDashboardService } from "src/services/administrator.dashboard/administrator.dashboard.service";

@Controller("api/admin/dashboard") //kada ovdje dodamo prefiks, onda ne moramo dolje ispod, podrazumijeva se
export class AdministratorDashboardController {
  constructor(
    // Uključiti servise administratora
    private service: AdministratorDashboardService
  ) {}
  /* Articles */
  @Get("articles")
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles("administrator")
  getAllArticles(): Promise<Article[]> {
    return this.service.getAllArticles();
  }

  @Get("article")
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles("administrator")
  getLastArticle(): Promise<Article> {
    return this.service.getLastArticle();
  }

  //Search article
  @Get("articles/s")
  async searchPaginationArticle(
    @Query("perPage") perPage: number = 10,
    @Query("page") page: number = 1,
    @Query("query") query: string = ""
  ) {
    const offset = (page - 1) * perPage;
    return this.service.searchPaginationArticle(perPage, offset, query);
  }

  /* Stocks */
  @Get("stocks")
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles("administrator")
  getAllStocks(): Promise<Stock[]> {
    return this.service.getAllStocks();
  }

  @Get("stock")
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles("administrator")
  getLastStock(): Promise<Stock> {
    return this.service.getLastStock();
  }

  /* Documents */

  @Get("documents")
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles("administrator")
  getAllDocuments(): Promise<Documents[]> {
    return this.service.getAllDocuments();
  }

  @Get("document")
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles("administrator")
  getLastDocument(): Promise<Documents> {
    return this.service.getLastDocument();
  }

  @Get("document/unsigned")
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles("administrator")
  getUnsignedDocuments(): Promise<[Documents[], number]> {
    return this.service.getUnsignedDocuments();
  }

  /* Svi administratori */
  @Get()
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles("administrator")
  getAll(): Promise<Administrator[]> {
    return this.service.getAll();
  }
  /* Administrator po ID */
  @Get(":id")
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles("administrator")
  getById(
    @Param("id") administratorId: number
  ): Promise<Administrator | ApiResponse> {
    return new Promise(async (resolve) => {
      const admin = await this.service.getById(administratorId);
      if (admin === undefined) {
        resolve(new ApiResponse("error", -8002));
      }
      resolve(admin);
    });
  }
}
