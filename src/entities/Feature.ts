import {
  Column,
  Entity,
  Index,
  JoinColumn,
  JoinTable,
  ManyToMany,
  ManyToOne,
  OneToMany,
  OneToOne,
  PrimaryGeneratedColumn,
} from 'typeorm';
import { Article } from './Article';
import { ArticleFeature } from './ArticleFeature';
import { Category } from './Category';

@Index('fk_feature_category_id', ['categoryId'], {})
@Entity('feature')
export class Feature {
  [x: string]: any;
  @PrimaryGeneratedColumn({ type: 'int', name: 'feature_id', unsigned: true })
  featureId: number;

  @Column('int', { name: 'category_id' })
  categoryId: number;

  @Column('varchar', { name: 'name', length: 255 })
  name: string;

  @OneToMany(() => ArticleFeature, (articleFeature) => articleFeature.feature)
  articleFeature: ArticleFeature;

  @ManyToOne(() => Category, (category) => category.features, {
    onDelete: 'RESTRICT',
    onUpdate: 'CASCADE',
  })
  @JoinColumn([{ name: 'category_id', referencedColumnName: 'categoryId' }])
  category: Category;

  @ManyToMany((type) => Article, (article) => article.features)
  @JoinTable({
    name: 'article_feature',
    joinColumn: { name: 'feature_id', referencedColumnName: 'featureId' },
    inverseJoinColumn: {
      name: 'article_id',
      referencedColumnName: 'articleId',
    },
  })
  articles: Article[];
}
