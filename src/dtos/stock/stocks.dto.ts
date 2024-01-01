import { Article } from "src/entities/Article";
import { Category } from "src/entities/Category";
import { StockFeature } from "src/entities/StockFeature";
import { StockFeatureDTO } from "../stock.features/stock.features.dto";

export class StockDTO {
  stockId?: number;
  name?: string;
  excerpt?: string | null;
  description?: string | null;
  contract?: string | null;
  categoryId?: number;
  sapNumber?: string;
  valueOnContract?: number;
  valueAvailable?: number;
  timestamp?: Date;
  createdAt?: Date;

  articles?: Partial<Article>[];
  category?: Partial<Category>;
  stockFeatures?: Partial<StockFeatureDTO>[];
}
