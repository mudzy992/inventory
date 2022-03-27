import { Controller } from '@nestjs/common';
import { Crud } from '@nestjsx/crud';
import { Documents } from 'src/entities/Documents';
import { DocumentService } from 'src/services/document/document.service';

@Controller('api/document')
@Crud({
  model: {
    type: Documents,
  },
  params: {
    id: {
      field: 'documentsId',
      type: 'number',
      primary: true,
    },
  },
  query: {
    join: {
      userArticles: {
        eager: true,
      },
    },
  },
})
export class DocumentController {
  constructor(public service: DocumentService) {}
}
