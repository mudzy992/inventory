import { ArticleFeatureComponentDto } from './article.feature.component.dto';
import { ArticleStockComponentDto } from './article.stock.component.dto';

export class AddArticleDto {
  name: string;
  categoryId: number;
  excerpt: string;
  description: string;
  concract: string;
  comment: string;
  sap_number: string;
  stock: ArticleStockComponentDto;
  features: ArticleFeatureComponentDto[];
}
