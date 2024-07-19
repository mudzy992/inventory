import { Category } from "src/entities/Category";
import { StockFeature } from "src/entities/StockFeature";

export class FeatureDTO {
  featureId?: number;
  name?: string;
  categoryId?: number;
  
  category?: Partial<Category>;
  stockFeatures?: Partial<StockFeature>[];
}
