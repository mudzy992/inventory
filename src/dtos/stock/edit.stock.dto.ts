export class UpdateStockDto {
  name?: string;
  excerpt?: string | null;
  description?: string | null;
  contract?: string | null;
  categoryId?: number | null;
  sapNumber?: string | null;
  valueOnContract?: number | null;
  valueAvailable?: number | null;
  features?: UpdateFeatureDto[] | null;
}
export class UpdateFeatureDto {
  featureId?: number;
  value?: string;
}
