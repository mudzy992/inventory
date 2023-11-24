import { Controller, Post, Param, UploadedFile, UseInterceptors, Get, Query } from '@nestjs/common';
import { FileInterceptor } from '@nestjs/platform-express';
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
      articleTimelines: {
        eager: true,
      },
      article: {
        eager: true,
      },
    },
  },
})
export class DocumentController {
  constructor(public service: DocumentService) {}

  @Post(':id/upload')
  @UseInterceptors(FileInterceptor('file'))
  async uploadPdf(
    @Param('id') documentId: number,
    @UploadedFile() file,
  ): Promise<any> {
    try {
      await this.service.uploadPdf(documentId, file);
      return { message: 'PDF file uploaded successfully' };
    } catch (error) {
      console.error(error);
      return { message: 'Error uploading PDF file' };
    }
  }

  @Get()
  async getAll(){
    return this.service.getAll();
  } 

  @Get('p')
  async paginedDocuments(
    @Query('perPage') perPage: number = 10,
    @Query('offset') offset: number = 0,
  ) {
    return this.service.paginedDocuments(perPage, offset);
  }

  @Get('s')
  async articleSearchPaginationByStockId(
    @Query('perPage') perPage: number = 10,
    @Query('page') page: number = 1,
    @Query('query') query: string = '',
  ) {
    const offset = (page - 1) * perPage;
    return this.service.documentSearchPagination(perPage, offset, query);
  }
}
