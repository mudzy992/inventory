import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { TypeOrmCrudService } from '@nestjsx/crud-typeorm';
import { DebtItems } from 'src/entities/DebtItems';
import { Repository } from 'typeorm';

@Injectable()
export class DebtItemsService extends TypeOrmCrudService<DebtItems> {
  constructor(
    @InjectRepository(DebtItems)
    private readonly debtItems: Repository<DebtItems>,
  ) {
    super(debtItems);
  }
}