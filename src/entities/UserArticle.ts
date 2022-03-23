import {
  Column,
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  OneToMany,
  PrimaryGeneratedColumn,
} from 'typeorm';
import { DebtItems } from './DebtItems';
import { Destroyed } from './Destroyed';
import { Responsibility } from './Responsibility';
import { Article } from './Article';
import { Documents } from './Documents';
import { User } from './User';

@Index('fk_user_article_user_id', ['userId'], {})
@Index('fk_user_article_article_id', ['articleId'], {})
@Index('fk_user_article_document_id', ['documentId'], {})
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

  @Column('int', { name: 'article_id', unsigned: true })
  articleId: number;

  @Column('int', { name: 'document_id', unsigned: true })
  documentId: number;

  @Column('int', { name: 'user_id', nullable: true, unsigned: true })
  userId: number | null;

  @Column('varchar', { name: 'serial_number', length: 255 })
  serialNumber: string;

  @Column('enum', {
    name: 'status',
    nullable: true,
    enum: ['zaduženo', 'razduženo', 'otpisano'],
    default: () => "'zaduženo'",
  })
  status: 'zaduženo' | 'razduženo' | 'otpisano' | null;

  @Column('timestamp', {
    name: 'timestamp',
    nullable: true,
    default: () => 'CURRENT_TIMESTAMP',
  })
  timestamp: Date | null;

  @Column('varchar', { name: 'comment', nullable: true, length: 255 })
  comment: string | null;

  @OneToMany(() => DebtItems, (debtItems) => debtItems.userArticle)
  debtItems: DebtItems[];

  @OneToMany(() => Destroyed, (destroyed) => destroyed.userArticle)
  destroyeds: Destroyed[];

  @OneToMany(
    () => Responsibility,
    (responsibility) => responsibility.userArticle,
  )
  responsibilities: Responsibility[];

  @ManyToOne(() => Article, (article) => article.userArticles, {
    onDelete: 'NO ACTION',
    onUpdate: 'CASCADE',
  })
  @JoinColumn([{ name: 'article_id', referencedColumnName: 'articleId' }])
  article: Article;

  @ManyToOne(() => Documents, (documents) => documents.userArticles, {
    onDelete: 'NO ACTION',
    onUpdate: 'CASCADE',
  })
  @JoinColumn([{ name: 'document_id', referencedColumnName: 'documentsId' }])
  document: Documents;

  @ManyToOne(() => User, (user) => user.userArticles, {
    onDelete: 'NO ACTION',
    onUpdate: 'CASCADE',
  })
  @JoinColumn([{ name: 'user_id', referencedColumnName: 'userId' }])
  user: User;
}
