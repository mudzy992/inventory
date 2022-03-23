import { Column, Entity, OneToMany, PrimaryGeneratedColumn } from 'typeorm';
import { UserArticle } from './UserArticle';

@Entity('documents', { schema: 'inventory' })
export class Documents {
  @PrimaryGeneratedColumn({ type: 'int', name: 'documents_id', unsigned: true })
  documentsId: number;

  @Column('varchar', { name: 'path', length: 255 })
  path: string;

  @Column('int', { name: 'document_number', default: () => "'0'" })
  documentNumber: number;

  @OneToMany(() => UserArticle, (userArticle) => userArticle.document)
  userArticles: UserArticle[];
}
