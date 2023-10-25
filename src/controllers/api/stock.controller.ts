import { Controller, Get, Param, Post, Body, Put, Delete } from '@nestjs/common';
import { Crud } from '@nestjsx/crud';
import { AddStockDto } from 'src/dtos/stock/add.stock.dto';
import { UpdateStockDto } from 'src/dtos/stock/edit.stock.dto';
import { Stock } from 'src/entities/Stock';
import { ApiResponse } from 'src/misc/api.response.class';
import { StockService } from 'src/services/stock/stock.service';


@Controller('api/stock')
@Crud({
  model: {
    type: Stock,
  },
  query: {
    join: {
      articles: {
        eager: true,
      }, 
      category: {
        eager: true,
      },
    },
  },
})
export class StockController {
  constructor(private readonly stockService: StockService) {}

  @Get()
  async getAllStocks(): Promise<Stock[] | ApiResponse> {
    return this.stockService.getAllStocks();
  }

  @Get(':id')
  async getStockById(@Param('id') stockId: number): Promise<Stock | ApiResponse> {
    return this.stockService.getStockById(stockId);
  }

  @Get('c/:id')
  async getStockByCategoryId(@Param('id') categoryId: number): Promise<Stock[] | ApiResponse> {
    return this.stockService.getStockByCategoryId(categoryId);
  }

  @Post()
  async addStock(@Body() newStock: AddStockDto): Promise<Stock | ApiResponse> {
    return this.stockService.addStock(newStock);
  }

  @Put(':id')
  async updateStock(
    @Param('id') stockId: number,
    @Body() updatedStock: UpdateStockDto,
  ): Promise<ApiResponse> {
    return this.stockService.updateStock(stockId, updatedStock);
  }

  @Delete(':id')
  async deleteStock(@Param('id') stockId: number): Promise<ApiResponse> {
    return this.stockService.deleteStock(stockId);
  }
}
