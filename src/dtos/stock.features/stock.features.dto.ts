import { Feature } from "src/entities/Feature";
import { Stock } from "src/entities/Stock";

export class StockFeatureDTO {
  stockFeatureId?: number;
  stockId?: number;
  featureId?: number;
  value?: string;

  feature?: Partial<Feature>;
  stock?: Partial<Stock>;
}
