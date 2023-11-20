import { Controller, Post, Param, UploadedFile, UseInterceptors, Get } from '@nestjs/common';
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

  /* @Get()
  async getAll(){
    return this.service.getAll();
  } */

  @Get()
  async getAllTen() {
    return this.service.getAllTen(5);
  }
}
