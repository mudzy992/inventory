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
import { Documents } from "./Documents";

@Index(
  'article_id_user_id_timestamp_serial_number',
  ['articleId', 'userId', 'timestamp', 'serialNumber'],
  {
    unique: true,
  },
)
@Index("fk_debt_items_document_id", ["documentId"], {})
@Index('FK_debt_items_user_article', ['userId'], {})
@Index('fk_debt_items_user_article_id', ['userArticleId'], {})
@Entity('debt_items', { schema: 'inventory' })
export class DebtItems {
  @PrimaryGeneratedColumn({
    type: 'int',
    name: 'debt_items_id',
    unsigned: true,
  })
  debtItemsId: number;

  @Column('int', { name: 'user_article_id', unsigned: true })
  userArticleId: number;

  @Column('int', { name: 'article_id', unsigned: true })
  articleId: number;

  @Column('int', { name: 'user_id', unsigned: true })
  userId: number;

  @Column("int", { name: "document_id", unsigned: true })
  documentId: number;

  @Column('int', { name: 'value' })
  value: number;

  @Column('timestamp', {
    name: 'timestamp',
    default: () => 'CURRENT_TIMESTAMP',
  })
  timestamp: Date;

  @Column('varchar', { name: 'serial_number', nullable: true, length: 255 })
  serialNumber: string | null;

  @Column('varchar', {
    name: 'status',
    length: 50,
    default: () => "'razduženo'",
  })
  status: string;

  @Column('varchar', { name: 'comment', nullable: true, length: 255 })
  comment: string | null;

  @Column('varchar', { name: 'inv_broj', length: 50 })
  invBroj: string;

  @ManyToOne(() => Article, (article) => article.debtItems, {
    onDelete: 'RESTRICT',
    onUpdate: 'CASCADE',
  })
  @JoinColumn([{ name: 'article_id', referencedColumnName: 'articleId' }])
  article: Article;

  @ManyToOne(() => Documents, (documents) => documents.debtItems, {
    onDelete: "RESTRICT",
    onUpdate: "CASCADE",
  })
  @JoinColumn([{ name: "document_id", referencedColumnName: "documentsId" }])
  document: Documents;

  @ManyToOne(() => UserArticle, (userArticle) => userArticle.debtItems, {
    onDelete: 'RESTRICT',
    onUpdate: 'CASCADE',
  })
  @JoinColumn([
    { name: 'user_article_id', referencedColumnName: 'userArticleId' },
  ])
  userArticle: UserArticle;

  @ManyToOne(() => User, (user) => user.debtItems, {
    onDelete: 'RESTRICT',
    onUpdate: 'CASCADE',
  })
  @JoinColumn([{ name: 'user_id', referencedColumnName: 'userId' }])
  user: User;
}
