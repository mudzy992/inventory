import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { TypeOrmCrudService } from '@nestjsx/crud-typeorm';
import { UserArticle } from 'src/entities/UserArticle';
import { Repository } from 'typeorm';

@Injectable()
export class UserArticleService extends TypeOrmCrudService<UserArticle> {
  constructor(
    @InjectRepository(UserArticle)
    private readonly userArticle: Repository<UserArticle>,
  ) {
    super(userArticle);
  }
  async getBySerialNumber(serialNumber: string): Promise<UserArticle | null> {
    const article = await this.userArticle.findOne({
      serialNumber: serialNumber,
    });
    if (article) {
      return article;
    }
    return null;
  }
}
