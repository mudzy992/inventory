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
import { Article } from './Article';

@Index('article_id', ['articleId'], { unique: true })
@Entity('stock', { schema: 'inventory' })
export class Stock {
  @PrimaryGeneratedColumn({ type: 'int', name: 'stock_id', unsigned: true })
  stockId: number;

  @Column('timestamp', {
    name: 'timestamp',
    nullable: false,
    default: () => 'CURRENT_TIMESTAMP',
  })
  timestamp: Date;

  @Column('int', { name: 'article_id', unsigned: true })
  articleId: number;

  @Column('int', { name: 'value_on_concract' })
  valueOnConcract: number;

  @Column('int', { name: 'value_available' })
  valueAvailable: number;

  @Column('varchar', { name: 'sap_number', nullable: false })
  sapNumber: string;

  @OneToMany(() => Stock, (stock) => stock.articles)
  articlesInStock: Article[];

  /* @OneToMany(() => Article, (article) => article.stock)
  articleStocDestroys: ArticleStocDestroy[]; */

  @ManyToOne(() => Article, (article) => article.articlesInStock, {
    onDelete: 'RESTRICT',
    onUpdate: 'CASCADE',
  })
  @JoinColumn([{ name: 'article_id', referencedColumnName: 'articleId' }])
  articles: Article;

  /* @OneToMany((type) => Article, (article) => article.articleInStock)
  @JoinTable({
    name: 'article_stoc_destroy',
    joinColumn: { name: 'stock_id', referencedColumnName: 'stockId' },
    inverseJoinColumn: {
      name: 'article_id',
      referencedColumnName: 'articleId',
    },
  })
  articles: Stock[]; */
}
