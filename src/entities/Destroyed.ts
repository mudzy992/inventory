import {
  Column,
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  PrimaryGeneratedColumn,
} from 'typeorm';
import { Article } from './Article';
import { User } from './User';
import { UserArticle } from './UserArticle';

@Index(
  'article_id_user_id_serial_number',
  ['articleId', 'userId', 'serialNumber'],
  { unique: true },
)
@Index('fk_destroyed_user_id', ['userId'], {})
@Index('fk_destroyed_user_article_id', ['userArticleId'], {})
@Entity('destroyed', { schema: 'inventory' })
export class Destroyed {
  @PrimaryGeneratedColumn({ type: 'int', name: 'destroyed_id', unsigned: true })
  destroyedId: number;

  @Column('int', { name: 'user_article_id', unsigned: true })
  userArticleId: number;

  @Column('int', { name: 'article_id', unsigned: true, default: () => "'0'" })
  articleId: number;

  @Column('int', { name: 'user_id', unsigned: true, default: () => "'0'" })
  userId: number;

  @Column('int', { name: 'value', default: () => "'0'" })
  value: number;

  @Column('timestamp', {
    name: 'timestamp',
    default: () => 'CURRENT_TIMESTAMP',
  })
  timestamp: Date;

  @Column('varchar', { name: 'serial_number', length: 255 })
  serialNumber: string;

  @Column('varchar', {
    name: 'status',
    length: 50,
    default: () => "'otpisano'",
  })
  status: string;

  @Column('varchar', { name: 'comment', nullable: true, length: 255 })
  comment: string | null;

  @ManyToOne(() => Article, (article) => article.destroyeds, {
    onDelete: 'RESTRICT',
    onUpdate: 'CASCADE',
  })
  @JoinColumn([{ name: 'article_id', referencedColumnName: 'articleId' }])
  article: Article;

  @ManyToOne(() => User, (user) => user.destroyeds, {
    onDelete: 'RESTRICT',
    onUpdate: 'CASCADE',
  })
  @JoinColumn([{ name: 'user_id', referencedColumnName: 'userId' }])
  user: User;

  @ManyToOne(() => UserArticle, (userArticle) => userArticle.destroyeds, {
    onDelete: 'RESTRICT',
    onUpdate: 'CASCADE',
  })
  @JoinColumn([
    { name: 'user_article_id', referencedColumnName: 'userArticleId' },
  ])
  userArticle: UserArticle;
}
