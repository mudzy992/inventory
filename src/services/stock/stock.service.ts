import { Injectable } from "@nestjs/common";
import { Stock } from "src/entities/Stock";
import { InjectRepository } from "@nestjs/typeorm";
import { Repository } from "typeorm";
import { TypeOrmCrudService } from "@nestjsx/crud-typeorm";
import { ApiResponse } from "src/misc/api.response.class";
import { UpdateStockDto } from "src/dtos/stock/edit.stock.dto";
import { StockFeature } from "src/entities/StockFeature";
import { CreateStockDto } from "src/dtos/stock/CreateStock.dto";

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

      // Ako koristite TypeORM, možete koristiti `save` za čuvanje novog stock-a
      const createdStock = await this.stockRepository.save(stock);

      // Dodavanje vrednosti za stock, pretpostavimo da imate odgovarajući DTO
      if (newStock.features) {
        for (const feature of newStock.features) {
          const stockFeature = new StockFeature();
          stockFeature.featureId = feature.featureId;
          stockFeature.value = feature.value;
          stockFeature.stock = createdStock; // Postavljanje veze sa stock-om

          // Ako koristite TypeORM, možete koristiti `save` za čuvanje novog stock feature-a
          await this.stockFeatureRepository.save(stockFeature);
        }
      }

      return createdStock;
      /* Prilagoditi malo povratni stock sa relacijama kako bi bio prikazan full (mada i ne treba) */
    } catch (error) {
      // Obrada greške ako je potrebno
      throw new ApiResponse(
        "error",
        -1000,
        "Greška prilikom dodavanja artikla na skladište."
      );
    }
  }

  /* const stock = await this.stockRepository.findOne({ where: { stockId }, relations: ['category', 'category.features', 'category.features.stockFeatures'] }); */

  async updateStock(
    stockId: number,
    updatedStock: UpdateStockDto
  ): Promise<Stock | ApiResponse> {
    const stock = await this.stockRepository.findOne({
      where: { stockId },
      relations: ["stockFeatures", "stockFeatures.feature"],
    });
    try {
      if (updatedStock.features) {
        // Provjeriti koji stockFeature nedostaju u payload-u
        const stockFeaturesToRemove = stock.stockFeatures.filter(
          (existingFeature) =>
            !updatedStock.features.some(
              (updatedFeature) =>
                updatedFeature.featureId === existingFeature.featureId
            )
        );

        // Obriši StockFeature entitete koji nisu prisutni u payload-u
        await Promise.all(
          stockFeaturesToRemove.map(async (featureToRemove) => {
            await this.stockFeatureRepository.remove(featureToRemove);
          })
        );

        // Iteriraj kroz feature-ove u payload-u
        for (const updatedFeature of updatedStock.features) {
          const feature = stock.stockFeatures.find(
            (f) => f.feature.featureId === updatedFeature.featureId
          );

          if (!feature) {
            // Ako ne postoji, kreirajte novi StockFeature i dodajte ga u stock.stockFeatures
            const newStockFeature = new StockFeature();
            newStockFeature.stockId = stockId;
            newStockFeature.featureId = updatedFeature.featureId;
            newStockFeature.value = updatedFeature.value;

            stock.stockFeatures.push(newStockFeature); // Dodajte novi StockFeature u stock.stockFeatures

            const savedFeature = await this.stockFeatureRepository.save(
              newStockFeature
            );
          } else {
            // Ako postoji, izvršite ažuriranje
            if (updatedFeature.value !== undefined) {
              feature.value = updatedFeature.value;
              const savedFeature = await this.stockFeatureRepository.save(
                feature
              );
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

  async getStockById(stockId: number): Promise<Stock | ApiResponse> {
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
    if (!stock) {
      return new ApiResponse(
        "error",
        -1003,
        "Skladište artikla nije pronađeno. Moguće da artikal ne postoji na skladištu."
      );
    }
    return stock;
  }

  async getStockByCategoryId(
    categoryId: number
  ): Promise<Stock[] | ApiResponse> {
    const stock = await this.stockRepository.find({
      where: { categoryId: categoryId },
      relations: ["category"],
    });
    if (!stock) {
      return new ApiResponse(
        "error",
        -1004,
        "Skladište artikla za tu kategoriju nije pronađeno. Moguće da artikal ne postoji na skladištu."
      );
    }
    return stock;
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
