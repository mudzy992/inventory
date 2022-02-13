import {
  Column,
  Entity,
  JoinTable,
  ManyToMany,
  OneToMany,
  PrimaryGeneratedColumn,
} from 'typeorm';
import { Article } from './Article';
import { UserArticle } from './UserArticle';

@Entity('user', { schema: 'inventory' })
export class User {
  @PrimaryGeneratedColumn({ type: 'int', name: 'user_id', unsigned: true })
  userId: number;

  @Column('varchar', { name: 'surname', length: 45 })
  surname: string;

  @Column('varchar', { name: 'forname', length: 45 })
  forname: string;

  @Column('varchar', { name: 'job_title', nullable: true, length: 45 })
  jobTitle: string | null;

  @Column('varchar', { name: 'department', nullable: true, length: 45 })
  department: string | null;

  @Column('varchar', { name: 'location', length: 45 })
  location: string;

  @OneToMany(() => UserArticle, (userArticle) => userArticle.user)
  userArticles: UserArticle[];

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
}
