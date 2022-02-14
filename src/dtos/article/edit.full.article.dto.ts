import { ArticleFeatureComponentDto } from './article.feature.component.dto';

export class EditFullArticleDto {
  name: string;
  categoryId: number;
  excerpt: string;
  description: string;
  concract: string;
  comment: string;
  stock: {
    valueOnConcract: number;
    valueAvailable: number;
    sap_number: string;
  };
  features: ArticleFeatureComponentDto[] | null;
}
