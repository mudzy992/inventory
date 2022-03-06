import {
  Column,
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  OneToMany,
  PrimaryGeneratedColumn,
} from 'typeorm';
import { Article } from './Article';
import { User } from './User';
import { UserArticle } from './UserArticle';

@Index(
  'article_id_user_id_serial_number',
  ['articleId', 'userId', 'serialNumber'],
  {
    unique: true,
  },
)
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

  @Column('varchar', { name: 'serial_number' })
  serialNumber: string;

  @Column('varchar', { name: 'status', length: 50, default: () => 'otpisano' })
  status: string;

  @ManyToOne(() => Article, (article) => article.destroyed, {
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

  @OneToMany(() => UserArticle, (userArticle) => userArticle.destroy)
  userArticle: UserArticle[];
}
