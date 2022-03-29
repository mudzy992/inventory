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
  'user_id_article_id_serial_number',
  ['userId', 'articleId', 'serialNumber'],
  { unique: true },
)
@Index('FK_104', ['articleId'], {})
@Index('FK_92', ['userId'], {})
@Index("fk_responsibility_document_id", ["documentId"], {})
@Index('fk_responsibility_user_article_id', ['userArticleId'], {})
@Entity('responsibility', { schema: 'inventory' })
export class Responsibility {
  @PrimaryGeneratedColumn({
    type: 'int',
    name: 'responsibility_id',
    unsigned: true,
  })
  responsibilityId: number;

  @Column('int', { name: 'user_article_id', unsigned: true })
  userArticleId: number;

  @Column('int', { name: 'user_id', unsigned: true, default: () => "'0'" })
  userId: number;

  @Column('int', { name: 'article_id', unsigned: true, default: () => "'0'" })
  articleId: number;

  @Column("int", { name: "document_id", unsigned: true })
  documentId: number;

  @Column('int', { name: 'value', default: () => "'0'" })
  value: number;

  @Column('enum', {
    name: 'status',
    enum: ['zaduženo', 'razduženo', 'otpisano'],
    default: () => "'zaduženo'",
  })
  status: 'zaduženo' | 'razduženo' | 'otpisano';

  @Column('timestamp', {
    name: 'timestamp',
    default: () => 'CURRENT_TIMESTAMP',
  })
  timestamp: Date;

  @Column('varchar', { name: 'serial_number', length: 255 })
  serialNumber: string;

  @Column('varchar', { name: 'inv_broj', length: 50 })
  invBroj: string;

  @ManyToOne(() => Article, (article) => article.responsibilities, {
    onDelete: 'RESTRICT',
    onUpdate: 'CASCADE',
  })
  @JoinColumn([{ name: 'article_id', referencedColumnName: 'articleId' }])
  article: Article;

  @ManyToOne(() => Documents, (documents) => documents.responsibilities, {
    onDelete: "RESTRICT",
    onUpdate: "CASCADE",
  })
  @JoinColumn([{ name: "document_id", referencedColumnName: "documentsId" }])
  document: Documents;

  @ManyToOne(() => User, (user) => user.responsibilities, {
    onDelete: 'RESTRICT',
    onUpdate: 'CASCADE',
  })
  @JoinColumn([{ name: 'user_id', referencedColumnName: 'userId' }])
  user: User;

  @ManyToOne(() => UserArticle, (userArticle) => userArticle.responsibilities, {
    onDelete: 'RESTRICT',
    onUpdate: 'CASCADE',
  })
  @JoinColumn([
    { name: 'user_article_id', referencedColumnName: 'userArticleId' },
  ])
  userArticle: UserArticle;
}
