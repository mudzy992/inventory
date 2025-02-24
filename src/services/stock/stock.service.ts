import { Injectable } from "@nestjs/common";
import { Stock } from "src/entities/Stock";
import { InjectRepository } from "@nestjs/typeorm";
import { Repository } from "typeorm";
import { TypeOrmCrudService } from "@nestjsx/crud-typeorm";
import { ApiResponse } from "src/misc/api.response.class";
import { UpdateStockDto } from "src/dtos/stock/edit.stock.dto";
import { StockFeature } from "src/entities/StockFeature";
import { CreateStockDto } from "src/dtos/stock/CreateStock.dto";
import { StockDTO } from "src/dtos/stock/stocks.dto";

@Injectable()
export class StockService extends TypeOrmCrudService<Stock> {
  constructor(
    @InjectRepository(Stock)
    private readonly stockRepository: Repository<Stock>,

    @InjectRepository(StockFeature)
    private readonly stockFeatureRepository: Repository<StockFeature>
  ) {
    super(stockRepository);
  }

  async createStock(newStock: CreateStockDto): Promise<Stock | ApiResponse> {
    try {
      const stock = new Stock();
      stock.name = newStock.name;
      stock.excerpt = newStock.excerpt;
      stock.description = newStock.description;
      stock.contract = newStock.contract;
      stock.categoryId = newStock.categoryId;
      stock.sapNumber = newStock.sapNumber;
      stock.valueAvailable = newStock.valueAvailable;
      stock.valueOnContract = newStock.valueOnContract;
      const createdStock = await this.stockRepository.save(stock);

      // Dodavanje vrijednosti za stock, pretpostavimo da imate odgovarajući DTO
      if (newStock.features) {
        for (const feature of newStock.features) {
          const stockFeature = new StockFeature();
          stockFeature.featureId = feature.featureId;
          stockFeature.value = feature.value;
          stockFeature.stock = createdStock; // Postavljanje veze sa stock-om
          await this.stockFeatureRepository.save(stockFeature);
        }
      }

      return createdStock;
    } catch (error) {
      throw new ApiResponse(
        "error",
        -1000,
        "Greška prilikom dodavanja artikla na skladište."
      );
    }
  }

  async updateStock(
    stockId: number,
    updatedStock: UpdateStockDto
  ): Promise<Stock | ApiResponse> {
    console.log(updatedStock);

    const stock = await this.stockRepository.findOne({
      where: { stockId },
      relations: ["stockFeatures", "stockFeatures.feature"],
    });

    if (!stock) {
      return new ApiResponse("error", -1002, "Skladište nije pronađeno.");
    }

    try {
      if (updatedStock.features) {
        // 1️⃣ Pronađi koje feature-e treba obrisati
        const stockFeaturesToRemove = stock.stockFeatures.filter(
          (existingFeature) =>
            !updatedStock.features.some(
              (updatedFeature) =>
                updatedFeature.featureId === existingFeature.feature.featureId
            )
        );

        // 2️⃣ Obriši ih iz baze
        if (stockFeaturesToRemove.length > 0) {
          await this.stockFeatureRepository.remove(stockFeaturesToRemove);
        }

        // 3️⃣ Iteriraj kroz feature-ove u payload-u i obavi dodavanje ili ažuriranje
        const featurePromises = updatedStock.features.map(async (updatedFeature) => {
          let feature = stock.stockFeatures.find(
            (f) => f.feature.featureId === updatedFeature.featureId
          );

          if (!feature) {
            // Dodavanje novog feature-a
            const newStockFeature = new StockFeature();
            newStockFeature.stockId = stockId;
            newStockFeature.featureId = updatedFeature.featureId;
            newStockFeature.value = updatedFeature.value;

            return this.stockFeatureRepository.save(newStockFeature);
          } else if (feature.value !== updatedFeature.value) {
            // Ažuriranje postojećeg feature-a
            feature.value = updatedFeature.value;
            return this.stockFeatureRepository.save(feature);
          }
        });

        // ✅ Paralelno izvršavanje svih operacija
        await Promise.all(featurePromises);
      }

      // 4️⃣ Ažuriranje osnovnih podataka
      stock.name = updatedStock.name;
      stock.excerpt = updatedStock.excerpt;
      stock.description = updatedStock.description;
      stock.contract = updatedStock.contract;
      stock.categoryId = updatedStock.categoryId;
      stock.sapNumber = updatedStock.sapNumber;
      stock.valueAvailable = updatedStock.valueAvailable;
      stock.valueOnContract = updatedStock.valueOnContract;

      await this.stockRepository.save(stock);

      return stock;
    } catch (error) {
      return new ApiResponse(
        "error",
        -1001,
        "Greška prilikom izmjene artikla na skladištu. Greška: " + error
      );
    }
  }

  async deleteStock(stockId: number): Promise<ApiResponse> {
    try {
      await this.getStockById(stockId); // Ensure the stock exists
      await this.stockRepository.delete(stockId);
      return new ApiResponse(
        "ok",
        200,
        "Artikal uspješno uklonjen sa skladišta."
      );
    } catch (error) {
      return new ApiResponse(
        "error",
        -1002,
        "Greška prilikom uklanjanja artikla sa skladišta."
      );
    }
  }

  async getStockById(stockId: number): Promise<StockDTO | ApiResponse> {
    const stock = await this.stockRepository.findOne({
      where: { stockId: stockId },
      relations: [
        "articles",
        "articles.user",
        "category",
        "stockFeatures",
        "stockFeatures.feature",
      ],
    });

    const response: StockDTO = {
      stockId: stock.stockId,
      categoryId: stock.categoryId,
      name: stock.name,
      description: stock.description,
      excerpt: stock.excerpt,
      contract: stock.contract,
      valueAvailable: stock.valueAvailable,
      valueOnContract: stock.valueOnContract,
      sapNumber: stock.sapNumber,
      timestamp: stock.timestamp,
      category: {
        imagePath: stock.category.imagePath,
      },
      stockFeatures: stock.stockFeatures,
    }
    if (!response) {
      return new ApiResponse(
        "error",
        -1003,
        "Skladište artikla nije pronađeno. Moguće da artikal ne postoji na skladištu."
      );
    }
    return response;
  }

  async getStockByCategoryId(
    categoryId: number
  ): Promise<StockDTO[] | ApiResponse> {
    const stock = await this.stockRepository.find({
      where: { categoryId: categoryId },
      relations: ["category"],
    });
    const response:StockDTO[] = await stock.map((item) => ({
      stockId: item.stockId,
      name: item.name,
      valueAvailable: item.valueAvailable,
      valueOnContract: item.valueOnContract,
      sapNumber: item.sapNumber,
    }))

    if (!response) {
      return new ApiResponse(
        "error",
        -1004,
        "Skladište artikla za ovu kategoriju ne psotoji. Moguće da artikal ne postoji na skladištu."
      );
    }
    return response;
  }

  async getAllStocks(): Promise<Stock[] | ApiResponse> {
    const stock = await this.stockRepository.find({
      relations: [
        "articles",
        "category",
        "category.features",
        "category.features.stockFeatures",
      ],
    });
    if (!stock) {
      return new ApiResponse(
        "error",
        -1005,
        "Skladište artikla nije pronađeno. Moguće da artikal ne postoji na skladištu."
      );
    }

    return stock;
  }
}
