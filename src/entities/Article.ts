import {
  Column,
  Entity,
  Index,
  JoinColumn,
  JoinTable,
  ManyToMany,
  ManyToOne,
  OneToMany,
  PrimaryGeneratedColumn,
} from 'typeorm';
import { Category } from './Category';
import { ArticleFeature } from './ArticleFeature';
import { Responsibility } from './Responsibility';
import { Feature } from './Feature';
import { User } from './User';
import { Stock } from './Stock';
import { Destroyed } from './Destroyed';
import { DebtItems } from './DebtItems';
import { Documents } from "./Documents";
import { UserArticle } from './UserArticle';

@Index('fk_article_category_id', ['categoryId'], {})
@Entity('article')
export class Article {
  @PrimaryGeneratedColumn({ type: 'int', name: 'article_id', unsigned: true })
  articleId: number;

  @Column('varchar', { name: 'name', length: 45 })
  name: string;

  @Column('varchar', { name: 'excerpt', length: 255 })
  excerpt: string;

  @Column('varchar', { name: 'description', length: 450 })
  description: string;

  @Column('varchar', { name: 'comment', nullable: true })
  comment: string | null;

  @Column('varchar', { name: 'concract' })
  concract: string;

  @Column('int', { name: 'category_id', unsigned: true })
  categoryId: number;

  @Column('varchar', { name: 'sap_number', nullable: false })
  sapNumber: string;

  @ManyToOne(() => Category, (category) => category.articles, {
    onDelete: 'RESTRICT',
    onUpdate: 'CASCADE',
  })
  @JoinColumn([{ name: 'category_id', referencedColumnName: 'categoryId' }])
  category: Category;

  @OneToMany(() => ArticleFeature, (articleFeature) => articleFeature.article)
  articleFeature: ArticleFeature[];

  @OneToMany(() => Documents, (documents) => documents.article)
  documents: Documents[];

  @OneToMany(() => Responsibility, (responsibility) => responsibility.article)
  responsibilities: Responsibility[];

  @OneToMany(() => Stock, (stock) => stock.articles)
  articlesInStock: Article[];

  @OneToMany(() => DebtItems, (debtItems) => debtItems.article)
  debtItems: DebtItems[];

  @OneToMany(() => Destroyed, (destroyed) => destroyed.article)
  destroyeds: Destroyed[];

  @OneToMany(() => UserArticle, (userArticle) => userArticle.article)
  userArticles: UserArticle[];

  @ManyToMany(() => User, (user) => user.articles)
  @JoinTable({
    name: 'user_article',
    joinColumn: { name: 'article_id', referencedColumnName: 'articleId' },
    inverseJoinColumn: {
      name: 'user_id',
      referencedColumnName: 'userId',
    },
  })
  userDetails: User[];

  @ManyToMany((type) => Feature, (feature) => feature.articles)
  @JoinTable({
    name: 'article_feature',
    joinColumn: { name: 'article_id', referencedColumnName: 'articleId' },
    inverseJoinColumn: {
      name: 'feature_id',
      referencedColumnName: 'featureId',
    },
  })
  features: Feature[];
}
