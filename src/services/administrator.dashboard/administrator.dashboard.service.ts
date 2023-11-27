import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Administrator } from 'src/entities/Administrator';
import { Brackets, IsNull, Repository } from 'typeorm';
import { ApiResponse } from 'src/misc/api.response.class';
import { Article } from 'src/entities/Article';
import { Stock } from 'src/entities/Stock';
import { Documents } from 'src/entities/Documents';

@Injectable()
export class AdministratorDashboardService {
  constructor(
    @InjectRepository(Administrator)
    private readonly administrator: Repository<Administrator>,
    @InjectRepository(Article)
    private readonly article: Repository<Article>,
    @InjectRepository(Stock)
    private readonly stock: Repository<Stock>,
    @InjectRepository(Documents)
    private readonly documents: Repository<Documents>,
  ) {}
  /* Articles */
  async getAllArticles(): Promise<Article[]> {
     const articles = await this.article.find({
      relations:['stock']
     })

    return articles
  }

  async getLastArticle(): Promise<Article> {
    const article = await this.article
        .createQueryBuilder('article')
        .leftJoinAndSelect('article.stock', 'stock')
        .leftJoinAndSelect('article.category', 'category')
        .leftJoinAndSelect('article.user', 'user')
        .orderBy('article.timestamp', 'DESC') 
        .take(1)
        .getOne();

   return article
 }


 async searchPaginationArticle(perPage: number, offset: number, query: string) {
  const resultsQuery = this.article
    .createQueryBuilder('article')
    .leftJoinAndSelect('article.stock', 'stock')
    .leftJoinAndSelect('article.user', 'user')
    .leftJoinAndSelect('article.category', 'category')
    .where((qb) => {
      if (query) {
        qb.andWhere(
          new Brackets((qb) => {
            qb.where('LOWER(user.fullname) LIKE LOWER(:query)', { query: `%${query}%` });
            qb.orWhere('LOWER(article.serialNumber) LIKE LOWER(:query)', { query: `%${query}%` });
            qb.orWhere('LOWER(article.invNumber) LIKE LOWER(:query)', { query: `%${query}%` });
            qb.orWhere('LOWER(stock.name) LIKE LOWER(:query)', { query: `%${query}%` });
          }),
        );
      }
    })
    .take(perPage)
    .skip(offset);

  const [results, totalResults] = await resultsQuery.getManyAndCount();

  return {
    results,
    total: totalResults,
  };
}


 /* Stocks */
  async getAllStocks(): Promise<Stock[]> {
    const stocks = await this.stock.find({
    relations:[]
    })

  return stocks
  }

  async getLastStock(): Promise<Stock> {
  const stock = await this.stock
      .createQueryBuilder('stock')
      .leftJoinAndSelect('stock.category', 'category')
      .orderBy('stock.createdAt', 'DESC') 
      .take(1)
      .getOne();
  return stock
  }

  /* Documents */
  async getAllDocuments(): Promise<Documents[]> {
    const documents = await this.documents.find({
    relations:[]
    })

  return documents
  }

  async getLastDocument(): Promise<Documents> {
  const document = await this.documents
      .createQueryBuilder('documents')
      .leftJoinAndSelect('documents.article', 'article') 
      .orderBy('documents.createdDate', 'DESC')
      .take(1)
      .getOne();
  return document
  }

  async getUnsignedDocuments(): Promise<[Documents[], number]> {
    const documents = await this.documents.findAndCount({
    where: { signed_path: IsNull() },
    relations:['article', 'article.stock','article.user','article.category']
    })

  return documents
  }

  /* Administrator */
  getAll(): Promise<Administrator[]> {
    return this.administrator.find();
  }


  getById(id: number): Promise<Administrator> {
    return this.administrator.findOne({where:{administratorId:id}});
  }

} /* Kraj koda */
