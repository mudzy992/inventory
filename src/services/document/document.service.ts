import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { TypeOrmCrudService } from '@nestjsx/crud-typeorm';
import { Documents } from 'src/entities/Documents';
import { Repository } from 'typeorm';
import * as fs from 'fs/promises';
import * as path from 'path';
import multer from 'multer';
import { StorageConfig } from 'config/storage.config';

@Injectable()
export class DocumentService extends TypeOrmCrudService<Documents> {
  constructor(
    @InjectRepository(Documents)
    private readonly document: Repository<Documents>,
  ) {
    super(document);
  }

  async findOneById(id: number): Promise<Documents | undefined> {
    try {
      const document = await this.document.findOne({ where: { documentsId: id } });
      return document || undefined;
    } catch (error) {
      console.error('Error fetching document:', error);
      return undefined;
    }
  }

  async updateDocumentPath(id: number, filePath: string): Promise<void> {
    await this.document.update(id, { signed_path: filePath });
  }

  async uploadPdf(documentId: number, file: multer.Multer.File): Promise<void> {
    try {
      if (!file) {
        throw new Error('PDF file not provided');
      }

      const document = await this.findOneById(documentId);
      if (!document) {
        throw new Error('Document not found');
      }

      const currentYear = new Date().getFullYear();
      const destination = path.join(
        StorageConfig.prenosnica.destination,
        `${currentYear}/potpisano`
      );
      await fs.mkdir(destination, { recursive: true });

      const fileName = `prenosnica-${document.documentNumber}.pdf`;
      const filePath = path.join(destination, fileName);

      // Sačuvaj binarne podatke fajla na ciljnu putanju
      await fs.writeFile(filePath, file.buffer);

      const storedPath = `${currentYear}/potpisano/${fileName}`;
      await this.updateDocumentPath(documentId, storedPath);
    } catch (error) {
      console.error('Error uploading PDF file:', error);
      throw new Error('Error uploading PDF file');
    }
  }

  async getAll(){
    return await this.document.find(
      {
        relations:['article','article.stock', 'article.user','articleTimelines']
      }
    )
  }

  async getAllTen(limit: number = 10) {
    return await this.document.find({
        relations: ['article', 'article.stock', 'article.user', 'articleTimelines'],
        take: limit, // Ovde postavljamo ograničenje na broj rezultata
    });
}
}
