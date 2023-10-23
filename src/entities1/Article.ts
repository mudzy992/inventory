import {
  Column,
  Entity,
  Index,
  JoinColumn,
  JoinTable,
  ManyToMany,
  ManyToOne,
  OneToMany,
  PrimaryGeneratedColumn,
} from "typeorm";
import { Category } from "./Category";
import { ArticleFeature } from "./ArticleFeature";
import { ArticleTimeline } from "./ArticleTimeline";
import { DebtItems } from "./DebtItems";
import { Destroyed } from "./Destroyed";
import { Documents } from "./Documents";
import { Responsibility } from "./Responsibility";
import { Stock } from "./Stock";
import { UpgradeFeature } from "./UpgradeFeature";
import { UserArticle } from "./UserArticle";
import { User } from "./User";
import { Feature } from "./Feature";

@Index("fk_article_category_id", ["categoryId"], {})
@Entity("article", { schema: "inventory" })
export class Article {
  @PrimaryGeneratedColumn({ type: "int", name: "article_id", unsigned: true })
  articleId: number;

  @Column("varchar", { name: "name", length: 255, default: () => "'0'" })
  name: string;

  @Column("varchar", { name: "excerpt", length: 255, default: () => "'0'" })
  excerpt: string;

  @Column("varchar", { name: "description", length: 450, default: () => "'0'" })
  description: string;

  @Column("varchar", { name: "concract", length: 255, default: () => "'0'" })
  concract: string;

  @Column("int", { name: "category_id", unsigned: true, default: () => "'0'" })
  categoryId: number;

  @Column("varchar", { name: "comment", nullable: true, length: 255 })
  comment: string | null;

  @Column("varchar", { name: "sap_number", length: 50, default: () => "'0'" })
  sapNumber: string;

  @ManyToOne(() => Category, (category) => category.articles, {
    onDelete: "RESTRICT",
    onUpdate: "CASCADE",
  })
  @JoinColumn([{ name: "category_id", referencedColumnName: "categoryId" }])
  category: Category;

  @OneToMany(() => ArticleFeature, (articleFeature) => articleFeature.article)
  articleFeature: ArticleFeature[];

  @OneToMany(
    () => ArticleTimeline,
    (articleTimeline) => articleTimeline.article
  )
  articleTimelines: ArticleTimeline[];

  @OneToMany(() => DebtItems, (debtItems) => debtItems.article)
  debtItems: DebtItems[];

  @OneToMany(() => Destroyed, (destroyed) => destroyed.article)
  destroyeds: Destroyed[];

  @OneToMany(() => Documents, (documents) => documents.article)
  documents: Documents[];

  @OneToMany(() => Responsibility, (responsibility) => responsibility.article)
  responsibilities: Responsibility[];

  @ManyToOne(() => Stock, (stock) => stock.stockArticle, {
    onDelete: 'RESTRICT',
    onUpdate: 'CASCADE',
  })
  @JoinColumn([{ name: 'article_id', referencedColumnName: 'articleId' }])
  articlesInStock: Stock;

  @OneToMany(() => UpgradeFeature, (upgradeFeature) => upgradeFeature.article)
  upgradeFeatures: UpgradeFeature[];

  @OneToMany(() => UserArticle, (userArticle) => userArticle.article)
  userArticles: UserArticle[];

  @ManyToMany(() => User, (user) => user.articles)
  @JoinTable({
    name: 'user_article',
    joinColumn: { name: 'article_id', referencedColumnName: 'articleId' },
    inverseJoinColumn: {
      name: 'user_id',
      referencedColumnName: 'userId',
    },
  })
  userDetails: User[];

  @ManyToMany((type) => Feature, (feature) => feature.articles)
  @JoinTable({
    name: 'article_feature',
    joinColumn: { name: 'article_id', referencedColumnName: 'articleId' },
    inverseJoinColumn: {
      name: 'feature_id',
      referencedColumnName: 'featureId',
    },
  })
  features: Feature[];
}
