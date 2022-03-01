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

@Index(
  'article_id_user_id_timestamp_serial_number',
  ['articleId', 'userId', 'timestamp', 'serialNumber'],
  {
    unique: true,
  },
)
@Index('fk_debt_items_user_id', ['userId'], {})
@Entity('debt_items', { schema: 'inventory' })
export class DebtItems {
  @PrimaryGeneratedColumn({
    type: 'int',
    name: 'debt_items_id',
    unsigned: true,
  })
  debtItemsId: number;

  @Column('int', { name: 'article_id', unsigned: true })
  articleId: number;

  @Column('int', { name: 'user_id', unsigned: true })
  userId: number;

  @Column('int', { name: 'value', unsigned: true })
  value: number;

  @Column('varchar', { name: 'comment', nullable: true, length: 255 })
  comment: string | null;

  @Column('varchar', { name: 'serial_number', length: 255 })
  serialNumber: string;

  @Column('timestamp', {
    name: 'timestamp',
    default: () => 'CURRENT_TIMESTAMP',
  })
  timestamp: Date;

  @ManyToOne(() => Article, (article) => article.debtItems, {
    onDelete: 'RESTRICT',
    onUpdate: 'CASCADE',
  })
  @JoinColumn([{ name: 'article_id', referencedColumnName: 'articleId' }])
  article: Article;

  @ManyToOne(() => User, (user) => user.debtItems, {
    onDelete: 'RESTRICT',
    onUpdate: 'CASCADE',
  })
  @JoinColumn([{ name: 'user_id', referencedColumnName: 'userId' }])
  user: User;
}
