import { Injectable } from "@nestjs/common";
import { InjectRepository } from "@nestjs/typeorm";
import { TypeOrmCrudService } from "@nestjsx/crud-typeorm";
import { Documents } from "src/entities/Documents";
import { Brackets, IsNull, Repository } from "typeorm";
import * as fs from "fs/promises";
import * as path from "path";
import multer from "multer";
import { StorageConfig } from "config/storage.config";

@Injectable()
export class DocumentService extends TypeOrmCrudService<Documents> {
  constructor(
    @InjectRepository(Documents)
    private readonly document: Repository<Documents>
  ) {
    super(document);
  }

  async findOneById(id: number): Promise<Documents | undefined> {
    try {
      const document = await this.document.findOne({
        where: { documentsId: id },
      });
      return document || undefined;
    } catch (error) {
      console.error("Error fetching document:", error);
      return undefined;
    }
  }

  async updateDocumentPath(id: number, filePath: string): Promise<void> {
    await this.document.update(id, { signed_path: filePath });
  }

  async uploadPdf(
    documentId: number,
    file?: multer.Multer.File,
    pathOverride?: string
    ): Promise<void> {
    try {
        const document = await this.findOneById(documentId);
        if (!document) {
        throw new Error("Document not found");
        }

        let storedPath: string;

        if (pathOverride) {
        storedPath = pathOverride;
        } else {
        if (!file) {
            throw new Error("PDF file not provided");
        }

        const currentYear = new Date().getFullYear();
        const destination = path.join(
            StorageConfig.prenosnica.destination,
            `${currentYear}/potpisano`
        );
        await fs.mkdir(destination, { recursive: true });

        const fileName = `prenosnica-${document.documentNumber}.pdf`;
        const filePath = path.join(destination, fileName);

        await fs.writeFile(filePath, file.buffer);

        storedPath = `${currentYear}/potpisano/${fileName}`;
        }

        await this.updateDocumentPath(documentId, storedPath);

        } catch (error) {
            console.error("Error uploading PDF file:", error);
            throw new Error("Error uploading PDF file");
        }
    }


  async getAll() {
    return await this.document.find({
      relations: [
        "article",
        "article.stock",
        "article.user",
        "articleTimelines",
      ],
    });
  }

  async paginedDocuments(perPage: number, offset: number) {
    const [results, totalResults] = await this.document.findAndCount({
      take: perPage,
      skip: offset,
      relations: [
        "article",
        "article.stock",
        "articleTimelines.user",
        "articleTimelines",
      ],
    });

    return {
      results,
      total: totalResults,
    };
  }

  async documentSearchPagination(
    perPage: number,
    offset: number,
    query: string
  ) {
    const resultsQuery = this.document
      .createQueryBuilder("document")
      .leftJoinAndSelect("document.article", "article")
      .leftJoinAndSelect("article.stock", "stock")
      .leftJoinAndSelect("document.articleTimelines", "articleTimelines")
      .leftJoinAndSelect("articleTimelines.user", "user")
      .leftJoinAndSelect("articleTimelines.subbmited", "subbmited")
      .where((qb) => {
        if (query) {
          qb.andWhere(
            new Brackets((qb) => {
              qb.where("user.fullname LIKE :query", { query: `%${query}%` });
              qb.orWhere("document.documentNumber LIKE :query", {
                query: `%${query}%`,
              });
              qb.orWhere("article.serialNumber LIKE :query", {
                query: `%${query}%`,
              });
              qb.orWhere("article.invNumber LIKE :query", {
                query: `%${query}%`,
              });
              qb.orWhere("stock.name LIKE :query", { query: `%${query}%` });
            })
          );
        }
      })
      .take(perPage)
      .skip(offset);

    const [results, totalResults] = await resultsQuery.getManyAndCount();

    return {
      results,
      total: totalResults,
    };
  }

  async getUnsignedDocuments(): Promise<[Documents[], number]> {
    const documents = await this.document.findAndCount({
      where: { signed_path: IsNull() },
      relations: [
        "articleTimelines",
        "articleTimelines.user",
        "articleTimelines.subbmited",
        "article",
        "article.stock",
        "article.user",
        "article.category",
      ],
    });

    return documents;
  }
}
