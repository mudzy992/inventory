import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { TypeOrmCrudService } from '@nestjsx/crud-typeorm';
import { Destroyed } from 'src/entities/Destroyed';
import { Repository } from 'typeorm';

@Injectable()
export class DestroyedArticlesService extends TypeOrmCrudService<Destroyed> {
  constructor(
    @InjectRepository(Destroyed)
    private readonly destroyedArticles: Repository<Destroyed>,
  ) {
    super(destroyedArticles);
  }
}