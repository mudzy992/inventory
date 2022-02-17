import {
  Column,
  Entity,
  Index,
  OneToMany,
  PrimaryGeneratedColumn,
} from 'typeorm';
import { Article } from './Article';

@Index('article_id', ['articleId'], { unique: true })
@Entity('destroyed', { schema: 'inventory' })
export class Destroyed {
  @PrimaryGeneratedColumn({ type: 'int', name: 'destroyed_id', unsigned: true })
  destroyedId: number;

  @Column('int', { name: 'article_id', unsigned: true })
  articleId: number;

  @Column('int', { name: 'value' })
  value: number;

  @Column('varchar', { name: 'comment' })
  comment: string;

  @Column('int', { name: 'user_id', unsigned: true })
  userId: number;

  /* @OneToMany(() => Article, (Article) => Article.articleDestroyed)
  destroyed: Article[]; */
}
