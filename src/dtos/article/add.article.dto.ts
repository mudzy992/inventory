import { ArticleFeatureComponentDto } from './article.feature.component.dto';

export class AddArticleDto {
  name: string;
  categoryId: number;
  excerpt: string;
  description: string;
  concract: string;
  comment: string;
  valueOnConcract: number;
  valueAvailable: number;
  sap_number: string;
  features: ArticleFeatureComponentDto[];
}
