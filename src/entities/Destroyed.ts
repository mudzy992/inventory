import {
  Column,
  Entity,
  Index,
  JoinColumn,
  JoinTable,
  ManyToOne,
  OneToMany,
  OneToOne,
  PrimaryGeneratedColumn,
} from 'typeorm';
import { Article } from './Article';
import { User } from './User';

@Index('article_id', ['articleId'], { unique: true })
@Entity('destroyed')
export class Destroyed {
  @PrimaryGeneratedColumn({ type: 'int', name: 'destroyed_id', unsigned: true })
  destroyedId: number;

  @Column('int', { name: 'article_id', unsigned: true })
  articleId: number;

  @Column('int', { name: 'value' })
  value: number;

  @Column('varchar', { name: 'comment' })
  comment: string;

  @Column('timestamp', {
    name: 'timestamp',
    nullable: false,
    default: () => 'CURRENT_TIMESTAMP',
  })
  timestamp: Date;

  @Column('int', { name: 'user_id', unsigned: true })
  userId: number;

  @ManyToOne(() => Article, (article) => article.destroyed, {
    onDelete: 'RESTRICT',
    onUpdate: 'CASCADE',
  })
  @JoinColumn([{ name: 'article_id', referencedColumnName: 'articleId' }])
  article: Article;

}
