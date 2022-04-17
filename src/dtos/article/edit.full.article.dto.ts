import { ArticleDetailsDto } from './article.details.dto';
import { ArticleFeatureComponentDto } from './article.feature.component.dto';
import { ArticleStockComponentDto } from './article.stock.component.dto';

export class EditFullArticleDto {
  categoryId: number;
  details: ArticleDetailsDto | null;
/*   name: string | null;
  categoryId: number | null;
  excerpt: string | null;
  description: string | null;
  concract: string | null;
  comment: string | null; */
  stock: ArticleStockComponentDto | null;
  features: ArticleFeatureComponentDto[] | null;
}
