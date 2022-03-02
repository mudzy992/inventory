import { Controller } from '@nestjs/common';
import { Crud } from '@nestjsx/crud';
import { DebtItems } from 'src/entities/DebtItems';
import { DebtItemsService } from 'src/services/debtItems/debt.items.service';

@Controller('api/debtArticles')
@Crud({
  model: {
    type: DebtItems,
  },
  params: {
    id: {
      field: 'debtItemsId',
      type: 'number',
      primary: true,
    },
  },
  query: {
    join: {
      article: {
        eager: true,
      },
      user: {
        eager: true,
      },
    },
  },
})
export class DebtItemsController {
  constructor(public service: DebtItemsService) {}
}