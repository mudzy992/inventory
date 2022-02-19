import {
  Column,
  Entity,
  Index,
  JoinTable,
  ManyToMany,
  OneToMany,
  PrimaryGeneratedColumn,
} from 'typeorm';
import { Article } from './Article';
import { DebtItems } from './DebtItems';
import { Destroyed } from './Destroyed';
import { UserArticle } from './UserArticle';

@Index('email', ['email'], { unique: true })
@Entity('user', { schema: 'inventory' })
export class User {
  @PrimaryGeneratedColumn({ type: 'int', name: 'user_id', unsigned: true })
  userId: number;

  @Column('varchar', { name: 'surname', length: 255 })
  surname: string;

  @Column('varchar', { name: 'forname', length: 255 })
  forname: string;

  @Column('varchar', { name: 'email', length: 255 })
  email: string;

  @Column('varchar', { name: 'job_title', nullable: true, length: 255 })
  jobTitle: string | null;

  @Column('varchar', { name: 'department', nullable: true, length: 255 })
  department: string | null;

  @Column('varchar', { name: 'location', length: 255 })
  location: string;

  @OneToMany(() => UserArticle, (userArticle) => userArticle.user)
  responsibilityArticles: UserArticle[];

  @ManyToMany((type) => Article, (article) => article.userDetails)
  @JoinTable({
    name: 'user_article',
    joinColumn: { name: 'user_id', referencedColumnName: 'userId' },
    inverseJoinColumn: {
      name: 'article_id',
      referencedColumnName: 'articleId',
    },
  })
  articles: Article[];

  @OneToMany(() => Destroyed, (destroyed) => destroyed.user)
  destroyeds: Destroyed[];

  @OneToMany(() => DebtItems, (debtItems) => debtItems.user)
  debtItems: DebtItems[];
}
