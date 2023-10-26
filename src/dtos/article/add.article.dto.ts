import { ArticleFeatureComponentDto } from './article.feature.component.dto';

export class AddArticleDto {
  serialNumber: string;
  invNumber: string;
  userId: number;
  status: "zaduženo" | "razduženo" | "otpisano";
  stockId: number;
  comment: string;
  features?: ArticleFeatureComponentDto[];
}
