import { Injectable } from '@nestjs/common';
import { Stock } from 'src/entities/Stock';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { TypeOrmCrudService } from '@nestjsx/crud-typeorm';
import { ApiResponse } from 'src/misc/api.response.class';
import { AddStockDto } from 'src/dtos/stock/add.stock.dto';
import { UpdateStockDto } from 'src/dtos/stock/edit.stock.dto';
import { StockFeature } from 'src/entities/StockFeature';


@Injectable()
export class StockService extends TypeOrmCrudService<Stock> {
  constructor(
    @InjectRepository(Stock)
    private readonly stockRepository: Repository<Stock>,

    @InjectRepository(StockFeature)
    private readonly stockFeatureRepository: Repository<StockFeature>,
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

  /* const stock = await this.stockRepository.findOne({ where: { stockId }, relations: ['category', 'category.features', 'category.features.stockFeatures'] }); */

  async updateStock(stockId: number, updatedStock: UpdateStockDto): Promise<Stock | ApiResponse> {
    const stock = await this.stockRepository.findOne({ where: { stockId }, relations: ['stockFeatures', 'stockFeatures.feature'] });
    try {       
        if (updatedStock.features) {
          for (const updatedFeature of updatedStock.features) {
            const feature = stock.stockFeatures.find((f) => f.feature.featureId === updatedFeature.featureId);
            
            if (feature) {
                const stockFeatures = stock.stockFeatures.find(
                  (af) => af.featureId === updatedFeature.featureId
                );

                if(!stockFeatures){
                  const newStockFeature = new StockFeature()
                  newStockFeature.featureId = updatedFeature.featureId;
                  newStockFeature.value = updatedFeature.value;

                  await this.stockRepository.save(newStockFeature)
                }
                
                if (stockFeatures) {
                  if (updatedFeature.value !== undefined) {
                    stockFeatures.value = updatedFeature.value;
                    await this.stockFeatureRepository.save(stockFeatures);
                    /* await this.stockFeatureRepository.update(stockFeatures.stockFeatureId, {value: updatedFeature.value}); */
                  }
                }
            }
          }
        }

        // Ažuriraj "core" podatke za artikal
        stock.name = updatedStock.name;
        stock.excerpt = updatedStock.excerpt;
        stock.description = updatedStock.description;
        stock.contract = updatedStock.contract;
        stock.categoryId = updatedStock.categoryId;
        stock.sapNumber = updatedStock.sapNumber;
        stock.valueAvailable = updatedStock.valueAvailable;
        stock.valueOnContract = updatedStock.valueOnContract;

        await this.stockRepository.save(stock);

        new ApiResponse('ok', 200, 'Artikal uspješno izmjenjen na skladištu.');
        
        return stock
    } catch (error) {
        return new ApiResponse('error', -1001, 'Greška prilikom izmjene artikla na skladištu. Greška: ' + error);
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
        relations: ['articles', 'articles.user', 'category', 'stockFeatures', 'stockFeatures.feature']
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
    const stock = await this.stockRepository.find({relations: ['articles', 'category', 'category.features', 'category.features.stockFeatures']});
    if (!stock) {
      return new ApiResponse('error', -1005, 'Skladište artikla nije pronađeno. Moguće da artikal ne postoji na skladištu.');
      }

      return stock;
  }
}
