import { Article } from "src/entities/Article";

export class UpgradeFeatureDTO {
  upgradeFeatureId?: number;
  name?: string;
  value?: string;
  timestamp?: Date | null;
  comment?: string | null;
  serialNumber?: string | null;
  articleId?: number;
  
  article?: Partial<Article>;
}
