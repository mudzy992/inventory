import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { TypeOrmCrudService } from '@nestjsx/crud-typeorm';
import { Stock } from 'src/entities/Stock';
import { Repository } from 'typeorm';

@Injectable()
export class StockService extends TypeOrmCrudService<Stock> {
  constructor(
    @InjectRepository(Stock)
    private readonly stock: Repository<Stock>, //Čim spomenenom neki repozitorijum moramo da taj repozitoriju evidentiramo u našem osnovnom modulu (app.module.ts)
  ) {
    super(stock);
  }
}