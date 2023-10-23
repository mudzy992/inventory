import {
  Column,
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  PrimaryGeneratedColumn,
} from 'typeorm';
import { Article } from './Article';
import { Feature } from './Feature';

@Index('feature_id', ['featureId'], { unique: true })
@Index('article_id', ['articleId'], { unique: true })
@Index('fk_article_feature_feature_id', ['featureId'], {})
@Entity('article_feature')
export class ArticleFeature {
  @PrimaryGeneratedColumn({
    type: 'int',
    name: 'article_feature_id',
    unsigned: true,
  })
  articleFeatureId: number;

  @Column('int', { name: 'article_id', unique: true, unsigned: true })
  articleId: number;

  @Column('int', { name: 'feature_id', unique: true, unsigned: true })
  featureId: number;

  @Column('varchar', { name: 'value', length: 255 })
  value: string;

  @ManyToOne(() => Article, (article) => article.articleFeature, {
    onDelete: 'RESTRICT',
    onUpdate: 'CASCADE',
  })
  @JoinColumn([{ name: 'article_id', referencedColumnName: 'articleId' }])
  article: Article;

  @ManyToOne(() => Feature, (feature) => feature.articleFeature, {
    onDelete: 'RESTRICT',
    onUpdate: 'CASCADE',
  })
  @JoinColumn([{ name: 'feature_id', referencedColumnName: 'featureId' }])
  feature: Feature;
}
