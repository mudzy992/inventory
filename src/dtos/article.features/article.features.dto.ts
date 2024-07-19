import { Article } from "src/entities/Article";
import { Feature } from "src/entities/Feature";

export class ArticleFeaturesDto {
    articleFeatureId: number;
    articleId: number;
    featureId: number;
    featureValue: string;
    article: Partial<Article>;
    feature: Partial<Feature>;
}