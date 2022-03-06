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
  'user_id_article_id_serial_number',
  ['articleId', 'userId', 'serialNumber'],
  {
    unique: true,
  },
)
@Index('FK_104', ['articleId'], {})
@Index('FK_92', ['userId'], {})
@Entity('responsibility')
export class Responsibility {
  @PrimaryGeneratedColumn({
    type: 'int',
    name: 'responsibility_id',
    unsigned: true,
  })
  responsibilityId: number;

  @Column('int', { name: 'user_id', unsigned: true })
  userId: number;

  @Column('int', { name: 'article_id', unsigned: true })
  articleId: number;

  @Column('int', { name: 'value' })
  value: number;

  @Column('enum', {
    name: 'status',
    enum: ['zaduženo', 'razduženo', 'otpisano'],
    default: () => "'zaduženo'",
  })
  status: 'zaduženo' | 'razduženo' | 'otpisano';

  @Column('timestamp', {
    name: 'timestamp',
    nullable: false,
    default: () => 'CURRENT_TIMESTAMP',
  })
  timestamp: Date;

  @Column('varchar', { name: 'serial_number', length: 255 })
  serialNumber: string;

  @ManyToOne(() => Article, (article) => article.responsibility, {
    onDelete: 'RESTRICT',
    onUpdate: 'CASCADE',
  })
  @JoinColumn([{ name: 'article_id', referencedColumnName: 'articleId' }])
  article: Article;

  @ManyToOne(() => User, (user) => user.responsibilityArticles, {
    onDelete: 'RESTRICT',
    onUpdate: 'CASCADE',
  })
  @JoinColumn([{ name: 'user_id', referencedColumnName: 'userId' }])
  user: User;

  @OneToMany(() => UserArticle, (userArticle) => userArticle.responsibility)
  userArticle: UserArticle[];
}
