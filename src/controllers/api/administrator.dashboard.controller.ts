import {
  Controller,
  Get,
  Param,
  Query,
  UseGuards,
} from "@nestjs/common";
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
    // Uključiti servise admina
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
}
