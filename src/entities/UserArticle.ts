import {
  Column,
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  PrimaryGeneratedColumn,
} from 'typeorm';
import { Article } from './Article';
import { DebtItems } from './DebtItems';
import { Destroyed } from './Destroyed';
import { Responsibility } from './Responsibility';
import { User } from './User';

@Index('fk_user_article_debt_id', ['debtId'], {})
@Index('fk_user_article_destroy_id', ['destroyId'], {})
@Index('fk_user_article_responsibility_id', ['responsibilityId'], {})
@Index('fk_user_article_user_id', ['userId'], {})
@Index(
  'serial_number_status_timestamp',
  ['serialNumber', 'status', 'timestamp'],
  { unique: true },
)
@Entity('user_article')
export class UserArticle {
  @PrimaryGeneratedColumn({
    type: 'int',
    name: 'user_article_id',
    unsigned: true,
  })
  userArticleId: number;

  @Column('int', {
    name: 'responsibility_id',
    unsigned: true,
  })
  responsibilityId: number;

  @Column('int', { name: 'debt_id', unsigned: true, nullable: true })
  debtId: number;

  @Column('int', { name: 'destroy_id', unsigned: true, nullable: true })
  destroyId: number;

  @Column('int', { name: 'user_id', unsigned: true, nullable: true })
  userId: number;

  @Column('int', { name: 'article_id', unsigned: true, nullable: false })
  articleId: number;

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

  @Column('varchar', { name: 'serial_number' })
  serialNumber: string;

  @ManyToOne(() => DebtItems, (debtItems) => debtItems.userArticle, {
    onDelete: 'SET NULL',
    onUpdate: 'CASCADE',
  })
  @JoinColumn([{ name: 'debt_id', referencedColumnName: 'debtItemsId' }])
  debt: DebtItems;

  @ManyToOne(() => Destroyed, (destroyed) => destroyed.userArticle, {
    onDelete: 'RESTRICT',
    onUpdate: 'CASCADE',
  })
  @JoinColumn([{ name: 'destroy_id', referencedColumnName: 'destroyedId' }])
  destroy: Destroyed;

  @ManyToOne(() => Responsibility, (response) => response.userArticle, {
    onDelete: 'SET NULL',
    onUpdate: 'CASCADE',
  })
  @JoinColumn([
    { name: 'responsibility_id', referencedColumnName: 'responsibilityId' },
  ])
  responsibility: Responsibility;

  @ManyToOne(() => User, (user) => user.userArticle, {
    onDelete: 'RESTRICT',
    onUpdate: 'CASCADE',
  })
  @JoinColumn([{ name: 'user_id', referencedColumnName: 'userId' }])
  user: User;

  @ManyToOne(() => Article, (article) => article.userArticle, {
    onDelete: 'RESTRICT',
    onUpdate: 'CASCADE',
  })
  @JoinColumn([{ name: 'article_id', referencedColumnName: 'articleId' }])
  article: Article;
}
