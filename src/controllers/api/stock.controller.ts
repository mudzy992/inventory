import {
  Controller,
  Get,
  Param,
  Post,
  Body,
  Put,
  Delete,
  Patch,
  UseGuards,
} from "@nestjs/common";
import { Crud } from "@nestjsx/crud";
import { CreateStockDto } from "src/dtos/stock/CreateStock.dto";
import { AddStockDto } from "src/dtos/stock/add.stock.dto";
import { UpdateStockDto } from "src/dtos/stock/edit.stock.dto";
import { Stock } from "src/entities/Stock";
import { AllowToRoles } from "src/misc/allow.to.roles.descriptor";
import { ApiResponse } from "src/misc/api.response.class";
import { RoleCheckedGuard } from "src/misc/role.checker.guard";
import { StockService } from "src/services/stock/stock.service";

@Controller("api/stock")
@Crud({
  model: {
    type: Stock,
  },
  query: {
    join: {
      stockArticle: {
        eager: true,
      },
      category: {
        eager: true,
      },
      stockFeatures: {
        eager: true,
      },
    },
  },
})
export class StockController {
  constructor(private readonly stockService: StockService) {}

  @Get()
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles("administrator", "moderator")
  async getAllStocks(): Promise<Stock[] | ApiResponse> {
    return this.stockService.getAllStocks();
  }

  @Get(":id")
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles("administrator", "moderator")
  async getStockById(
    @Param("id") stockId: number
  ): Promise<Stock | ApiResponse> {
    return this.stockService.getStockById(stockId);
  }

  @Get("c/:id")
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles("administrator", "moderator")
  async getStockByCategoryId(
    @Param("id") categoryId: number
  ): Promise<Stock[] | ApiResponse> {
    return this.stockService.getStockByCategoryId(categoryId);
  }

  @Post()
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles("administrator", "moderator")
  async addStock(
    @Body() newStock: CreateStockDto
  ): Promise<Stock | ApiResponse> {
    return this.stockService.createStock(newStock);
  }

  @Put(":id")
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles("administrator", "moderator")
  async updateStock(
    @Param("id") stockId: number,
    @Body() updatedStock: UpdateStockDto
  ): Promise<Stock | ApiResponse> {
    return this.stockService.updateStock(stockId, updatedStock);
  }

  @Delete(":id")
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles("administrator", "moderator")
  async deleteStock(@Param("id") stockId: number): Promise<ApiResponse> {
    return this.stockService.deleteStock(stockId);
  }
}
