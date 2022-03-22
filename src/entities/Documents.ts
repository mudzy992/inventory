import { Column, Entity, OneToMany, PrimaryGeneratedColumn } from "typeorm";
import { UserArticle } from "./UserArticle";

@Entity("documents", { schema: "inventory" })
export class Documents {
  @PrimaryGeneratedColumn({ type: "int", name: "documents_id", unsigned: true })
  documentsId: number;

  @Column("varchar", { name: "path", length: 255 })
  path: string;

  @OneToMany(() => UserArticle, (userArticle) => userArticle.document)
  userArticles: UserArticle[];
}
