import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { TypeOrmCrudService } from '@nestjsx/crud-typeorm';
import { Documents } from 'src/entities/Documents';
import { Repository } from 'typeorm';

@Injectable()
export class DocumentService extends TypeOrmCrudService<Documents> {
  constructor(
    @InjectRepository(Documents)
    private readonly document: Repository<Documents>, //Čim spomenenom neki repozitorijum moramo da taj repozitoriju evidentiramo u našem osnovnom modulu (app.module.ts)
  ) {
    super(document);
  }
}
