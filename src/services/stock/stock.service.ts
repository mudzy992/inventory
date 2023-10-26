import { Injectable } from '@nestjs/common';
import { Stock } from 'src/entities/Stock';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { TypeOrmCrudService } from '@nestjsx/crud-typeorm';
import { ApiResponse } from 'src/misc/api.response.class';
import { AddStockDto } from 'src/dtos/stock/add.stock.dto';
import { UpdateStockDto } from 'src/dtos/stock/edit.stock.dto';


@Injectable()
export class StockService extends TypeOrmCrudService<Stock> {
  constructor(
    @InjectRepository(Stock)
    private readonly stockRepository: Repository<Stock>,
  ) {
    super(stockRepository);
  }

  async addStock(newStock: AddStockDto): Promise<Stock | ApiResponse> {
    try {
      const stock = this.stockRepository.create(newStock);
      await this.stockRepository.save(stock);
      new ApiResponse('ok', 200, 'Artikal uspješno dodan na skladište.');
      return stock
    } catch (error) {
      return new ApiResponse('error', -1000, 'Greška prilikom dodavanja artikla na skladište.');
    }
  }

  async updateStock(stockId: number, updatedStock: UpdateStockDto): Promise<ApiResponse> {
    try {
      await this.getStockById(stockId); // Ensure the stock exists
      await this.stockRepository.update(stockId, updatedStock);
      return new ApiResponse('ok', 200, 'Artikal uspješno izmjenjen na skladištu.');
    } catch (error) {
      return new ApiResponse('error', -1001, 'Greška prilikom izmjene artikla na skladištu.');
    }
  }

  async deleteStock(stockId: number): Promise<ApiResponse> {
    try {
      await this.getStockById(stockId); // Ensure the stock exists
      await this.stockRepository.delete(stockId);
      return new ApiResponse('ok', 200, 'Artikal uspješno uklonjen sa skladišta.');
    } catch (error) {
      return new ApiResponse('error', -1002, 'Greška prilikom uklanjanja artikla sa skladišta.');
    }
  }

  async getStockById(stockId: number): Promise<Stock | ApiResponse> {
    const stock = await this.stockRepository.findOne(
      { 
        where: { stockId : stockId },
        relations: ['articles', 'articles.user', 'articles.articleFeatures','articles.articleFeatures.feature', 'category']
      });
    if (!stock) {
        return new ApiResponse('error', -1003, 'Skladište artikla nije pronađeno. Moguće da artikal ne postoji na skladištu.');
    }
    return stock;
  }

  async getStockByCategoryId(categoryId: number): Promise<Stock[] | ApiResponse> {
    const stock = await this.stockRepository.find
    ({ where: { categoryId: categoryId },
       relations: ['articles', 'category'], });
    if (!stock) {
        return new ApiResponse('error', -1004, 'Skladište artikla za tu kategoriju nije pronađeno. Moguće da artikal ne postoji na skladištu.');
    }
    return stock;
  }

  async getAllStocks(): Promise<Stock[] | ApiResponse> {
    const stock = await this.stockRepository.find({relations: ['articles', 'category']});
    if (!stock) {
      return new ApiResponse('error', -1005, 'Skladište artikla nije pronađeno. Moguće da artikal ne postoji na skladištu.');
      }

      return stock;
  }
}
