import { Controller } from '@nestjs/common';
import { Crud } from '@nestjsx/crud';
import { Stock } from 'src/entities/Stock';
import { StockService } from 'src/services/stock/stock.service';

@Controller('api/stock')
@Crud({
  model: {
    type: Stock,
  },
  params: {
    id: {
      field: 'stockId',
      type: 'number',
      primary: true,
    },
  },
  query: {
    join: {
      articles: {
        eager: true,
      },
    },
  },
})
export class StockController {
  constructor(public service: StockService) {}
}
