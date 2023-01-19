import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { TypeOrmCrudService } from '@nestjsx/crud-typeorm';
import { StorageConfig } from 'config/storage.config';
import createReport from 'docx-templates';
import { writeFileSync, readFileSync } from 'fs';
import { AddEmployeArticleDto } from 'src/dtos/user/add.employe.article.dto';
import { Article } from 'src/entities/Article';
import { ArticleTimeline } from 'src/entities/ArticleTimeline';
import { Documents } from 'src/entities/Documents';
import { Stock } from 'src/entities/Stock';
import { User } from 'src/entities/User';
import { UserArticle } from 'src/entities/UserArticle';
import { ApiResponse } from 'src/misc/api.response.class';
import { Repository } from 'typeorm';

@Injectable()
export class UserArticleService extends TypeOrmCrudService<UserArticle> {
  constructor(
    @InjectRepository(UserArticle)
    private readonly userArticle: Repository<UserArticle>,
    @InjectRepository(User)
    private readonly user: Repository<User>,
    @InjectRepository(Article)
    private readonly article: Repository<Article>,
    @InjectRepository(Stock)
    private readonly stock: Repository<Stock>,
    @InjectRepository(Documents)
    private readonly document: Repository<Documents>,
    @InjectRepository(ArticleTimeline)
    private readonly articleTimeline: Repository<ArticleTimeline>,
  ) {
    super(userArticle);
  }

  async addArticleToEmploye(
    userId: number,
    data: AddEmployeArticleDto,
  ): Promise <User | Stock | UserArticle | ApiResponse | ArticleTimeline> {
    
    let lastRecord = await this.document.findOne({
      order: {
        created_date: 'DESC'
      }
    })

    let currentYear = lastRecord ? new Date(lastRecord.created_date).getFullYear() : new Date().getFullYear();
    let documentNumber;

    if (currentYear === new Date().getFullYear()) {
        documentNumber = lastRecord ? lastRecord.documentNumber + 1 : 1;
    } else {
        documentNumber = 1;
        currentYear = new Date().getFullYear();
    }

    const exResponsibility: UserArticle = await this.userArticle.findOne({
      serialNumber: data.serialNumber,
      status: "zaduženo"
    });

    const exDebt: UserArticle = await this.userArticle.findOne({
      serialNumber: data.serialNumber,
      status: "razduženo"
    });

    const exDestroyed: UserArticle = await this.userArticle.findOne({
      serialNumber: data.serialNumber,
      status: "otpisano"
    });

    const checkArticleInStock: Stock = await this.stock.findOne({
      articleId: data.articleId,
    });

    if (!checkArticleInStock) {
      return new ApiResponse(
        'error',
        -2011,
        'Traženi artikal ne postoji u bazi podataka',
      );
    }

    if (checkArticleInStock.valueAvailable === 0) {
      return new ApiResponse(
        'error',
        -2005,
        'Na stanju više nema traženog artikla',
      );
    }

    if (exResponsibility) {
      if (exResponsibility.userId === userId) {
        return new ApiResponse(
          'error',
          -2002,
          'Artikal sa traženim serijskim brojem je već zadužen na korisnika',
        );
      } else if (exResponsibility.userId !== userId) {
        const ua: UserArticle = await this.userArticle.findOne({
          userArticleId: exResponsibility.userArticleId,
        });

        /* let lastRecord = await this.document.findOne({
          order: {
            created_date: 'DESC'
          }
        })

        let currentYear = lastRecord ? new Date(lastRecord.created_date).getFullYear() : new Date().getFullYear();
        let documentNumber;

        if (currentYear === new Date().getFullYear()) {
            documentNumber = lastRecord ? lastRecord.documentNumber + 1 : 1;
        } else {
            documentNumber = 1;
            currentYear = new Date().getFullYear();
        } */

        await this.createDocument('', '', '', '', '', userId, data);
    
        const newDocument: Documents = new Documents();
        newDocument.path = 'prenosnica' + documentNumber + '.docx';
        newDocument.documentNumber = documentNumber;
        newDocument.articleId = data.articleId;
    
        const savedDocument = await this.document.save(newDocument);
        if (!savedDocument) {
          return new ApiResponse('error', -2020, 'Prenosnica nije kreirana');
        }

        this.userArticle.update(ua, {
          documentId: savedDocument.documentsId,
          userId: userId,
          comment: data.comment,
        });
        
        const newArticleTimelineDebt: ArticleTimeline = new ArticleTimeline();
        newArticleTimelineDebt.documentId = savedDocument.documentsId;
        newArticleTimelineDebt.userId = exResponsibility.userId;
        newArticleTimelineDebt.serialNumber = data.serialNumber;
        newArticleTimelineDebt.invBroj = data.invBroj;
        newArticleTimelineDebt.articleId = data.articleId;
        newArticleTimelineDebt.comment = data.comment;
        newArticleTimelineDebt.status = "razduženo"

        await this.articleTimeline.save(newArticleTimelineDebt)

        const newArticleTimelineResp: ArticleTimeline = new ArticleTimeline();
        newArticleTimelineResp.documentId = savedDocument.documentsId;
        newArticleTimelineResp.userId = userId;
        newArticleTimelineResp.serialNumber = data.serialNumber;
        newArticleTimelineResp.invBroj = data.invBroj;
        newArticleTimelineResp.articleId = data.articleId;
        newArticleTimelineResp.comment = data.comment;
        newArticleTimelineResp.status = "zaduženo"

        await this.articleTimeline.save(newArticleTimelineResp)
        
        return
      }
    } else if (exDebt) {
      const ua: UserArticle = await this.userArticle.findOne({
        userArticleId: exDebt.userArticleId,
      });

      this.checkStock(data.articleId)

      /* let lastRecord = await this.document.findOne({
        order: {
          created_date: 'DESC'
        }
      })

      let currentYear = lastRecord ? new Date(lastRecord.created_date).getFullYear() : new Date().getFullYear();
      let documentNumber;

      if (currentYear === new Date().getFullYear()) {
          documentNumber = lastRecord ? lastRecord.documentNumber + 1 : 1;
      } else {
          documentNumber = 1;
          currentYear = new Date().getFullYear();
      } */
  
      await this.createDocument('', '', '', '', '', userId, data);

      const newDocument: Documents = new Documents();
      newDocument.path = 'prenosnica' + documentNumber + '.docx';
      newDocument.documentNumber = documentNumber;
      newDocument.articleId = data.articleId;
  
      const savedDocument = await this.document.save(newDocument);
      if (!savedDocument) {
        return new ApiResponse('error', -2020, 'Prenosnica nije kreirana');
      }

      this.userArticle.update(ua, {
        documentId: savedDocument.documentsId,
        userId: userId,
        status: 'zaduženo',
        comment: "Zaduženje nove opreme",
      });

      const newArticleTimeline: ArticleTimeline = new ArticleTimeline();
        newArticleTimeline.documentId = savedDocument.documentsId;
        newArticleTimeline.userId = userId;
        newArticleTimeline.serialNumber = data.serialNumber;
        newArticleTimeline.invBroj = data.invBroj;
        newArticleTimeline.articleId = data.articleId;
        newArticleTimeline.comment = data.comment;
        newArticleTimeline.status = "zaduženo"

        await this.articleTimeline.save(newArticleTimeline)
          
        const artStock: Stock = await this.stock.findOne({
          articleId: data.articleId,
        });
        this.stock.update(artStock, {
          valueAvailable: artStock.valueAvailable - 1,
        });

        if(exResponsibility){

          const newArticleTimelineDebt: ArticleTimeline = new ArticleTimeline();
          newArticleTimelineDebt.documentId = savedDocument.documentsId;
          newArticleTimelineDebt.userId = exResponsibility.userId;
          newArticleTimelineDebt.serialNumber = data.serialNumber;
          newArticleTimelineDebt.invBroj = data.invBroj;
          newArticleTimelineDebt.articleId = data.articleId;
          newArticleTimelineDebt.comment = data.comment;
          newArticleTimelineDebt.status = "razduženo"

          await this.articleTimeline.save(newArticleTimelineDebt)

      }
      return await this.userArticle.findOne({
        where: { articleId: data.articleId },
        relations: ['article', 'user', 'document'],
      });
    } else if (exDestroyed) {
      return new ApiResponse(
        'error',
        -2007,
        'Artikal sa traženim serijskim brojem je već uništen.',
      );
    }

    await this.createDocument('', '', '', '', '', userId, data);
    return this.addArticleInResponsibility(userId, data);
  }

  async debtArticleFromEmployee(
    userId: number,
    data: AddEmployeArticleDto,
  ): Promise < UserArticle | ApiResponse | ArticleTimeline> {

    this.checkStock(data.articleId)

    let lastRecord = await this.document.findOne({
      order: {
        created_date: 'DESC'
      }
    })

    let currentYear = lastRecord ? new Date(lastRecord.created_date).getFullYear() : new Date().getFullYear();
    let documentNumber;

    if (currentYear === new Date().getFullYear()) {
        documentNumber = lastRecord ? lastRecord.documentNumber + 1 : 1;
    } else {
        documentNumber = 1;
        currentYear = new Date().getFullYear();
    }

    const exDebt: UserArticle = await this.userArticle.findOne({
      serialNumber: data.serialNumber,
      status: "razduženo"
    });

    const exResponsibility: UserArticle = await this.userArticle.findOne({
      serialNumber: data.serialNumber,
      status: "zaduženo"
    });

    
    const artStock: Stock = await this.stock.findOne({
      articleId: data.articleId,
    });
    this.stock.update(artStock, {
      valueAvailable: artStock.valueAvailable + 1,
    });

    if(exDebt) {
        if (exDebt.userId == userId) {
        return new ApiResponse(
          'error',
          -2003,
          'Artikal sa traženim serijskim brojem je već razdužen sa korisnika',
        );
      }
    }

    const ua: UserArticle = await this.userArticle.findOne({
      userArticleId: exResponsibility.userArticleId,
    });
    
    await this.createDocument('', '', '', '', '', userId, data);

    const newDocument: Documents = new Documents();
    newDocument.path = 'prenosnica' + documentNumber + '.docx';
    newDocument.documentNumber = documentNumber;
    newDocument.articleId = data.articleId;

    const savedDocument = await this.document.save(newDocument);
    if (!savedDocument) {
      return new ApiResponse('error', -2020, 'Prenosnica nije kreirana');
    }

    this.userArticle.update(ua, {
      documentId: savedDocument.documentsId,
      status: 'razduženo',
      comment: data.comment,
    });

      const newArticleTimelineDebt: ArticleTimeline = new ArticleTimeline();
      newArticleTimelineDebt.documentId = savedDocument.documentsId;
      newArticleTimelineDebt.userId = exResponsibility.userId;
      newArticleTimelineDebt.serialNumber = data.serialNumber;
      newArticleTimelineDebt.invBroj = data.invBroj;
      newArticleTimelineDebt.articleId = data.articleId;
      newArticleTimelineDebt.comment = data.comment;
      newArticleTimelineDebt.status = "razduženo"

      await this.articleTimeline.save(newArticleTimelineDebt)

      return await this.userArticle.findOne({
        where: { articleId: data.articleId },
        relations: ['article', 'user', 'document'],
      });
  }

  async destroyeArticleFromEmployee(
    userId: number,
    data: AddEmployeArticleDto,
  ): Promise < UserArticle | ApiResponse | ArticleTimeline> {

    this.checkStock(data.articleId)

    let lastRecord = await this.document.findOne({
      order: {
        created_date: 'DESC'
      }
    })

    let currentYear = lastRecord ? new Date(lastRecord.created_date).getFullYear() : new Date().getFullYear();
    let documentNumber;

    if (currentYear === new Date().getFullYear()) {
        documentNumber = lastRecord ? lastRecord.documentNumber + 1 : 1;
    } else {
        documentNumber = 1;
        currentYear = new Date().getFullYear();
    }

    const exUserArticle: UserArticle = await this.userArticle.findOne({
      serialNumber: data.serialNumber,
    });

    if(exUserArticle) {
      if(exUserArticle.status === 'otpisano'){
        return new ApiResponse(
          'error',
          -2009,
          'Artikal sa traženim serijskim brojem je već ranije otpisan ili uništen',
        );
      }
    }
    
    await this.createDocument('', '', '', '', '', userId, data);

    const newDocument: Documents = new Documents();
    newDocument.path = 'prenosnica' + documentNumber + '.docx';
    newDocument.documentNumber = documentNumber;
    newDocument.articleId = data.articleId;

    const savedDocument = await this.document.save(newDocument);
    if (!savedDocument) {
      return new ApiResponse('error', -2020, 'Prenosnica nije kreirana');
    }

    if(exUserArticle) {
      const ua: UserArticle = await this.userArticle.findOne({
        userArticleId: exUserArticle.userArticleId,
      });

      this.userArticle.update(ua, {
        documentId: savedDocument.documentsId,
        status: 'otpisano',
        comment: data.comment,
      });

      if(exUserArticle.status === 'razduženo'){
        const artStock: Stock = await this.stock.findOne({
          articleId: data.articleId,
        });
    
        this.stock.update(artStock, {
          valueAvailable: artStock.valueAvailable - 1,
        });
      }
    }

      const newArticleTimelineDebt: ArticleTimeline = new ArticleTimeline();
      newArticleTimelineDebt.documentId = savedDocument.documentsId;
      newArticleTimelineDebt.userId = exUserArticle.userId;
      newArticleTimelineDebt.serialNumber = data.serialNumber;
      newArticleTimelineDebt.invBroj = data.invBroj;
      newArticleTimelineDebt.articleId = data.articleId;
      newArticleTimelineDebt.comment = data.comment;
      newArticleTimelineDebt.status = "otpisano"

      await this.articleTimeline.save(newArticleTimelineDebt)

      return await this.userArticle.findOne({
        where: { articleId: data.articleId },
        relations: ['article', 'user', 'document'],
      });
  }

  private async createDocument(
    predao: string,
    preuzeo: string,
    inv: string,
    naziv: string,
    komentar: string,
    userId,
    data,
  ) {
    let lastRecord = await this.document.findOne({
      order: {
        created_date: 'DESC'
      }
    })

    let currentYear = lastRecord ? new Date(lastRecord.created_date).getFullYear() : new Date().getFullYear();
    let documentNumber;

    if (currentYear === new Date().getFullYear()) {
        documentNumber = lastRecord ? lastRecord.documentNumber + 1 : 1;
    } else {
        documentNumber = 1;
        currentYear = new Date().getFullYear();
    }

    const exRes: UserArticle = await this.userArticle.findOne({
      serialNumber: data.serialNumber,
      status: "zaduženo",
    });

    if (exRes) {
      if(data.status === 'razduženo') {
        const predaoKorisnik: User = await this.user.findOne({
          userId: userId,
        });
        predao = predaoKorisnik.fullname;
        preuzeo = "Skladište"

      } else if (data.status === 'zaduženo') {
        const predaoKorisnik: User = await this.user.findOne({
          userId: exRes.userId,
        });
        predao = predaoKorisnik.fullname;
  
        const preuzeoKorisnik: User = await this.user.findOne({
          userId: userId,
        });
        preuzeo = preuzeoKorisnik.fullname;
      } 
    }

    if (!exRes) {
      const exDebt: UserArticle = await this.userArticle.findOne({
        serialNumber: data.serialNumber,
        status: "razduženo"
      });

      if (exDebt) {
      predao = 'Skladište';
      const preuzeoKorisnik: User = await this.user.findOne({
        userId: userId,
      });
      preuzeo = preuzeoKorisnik.fullname;
    }

    predao = 'Skladište';

  const preuzeoKorisnik: User = await this.user.findOne({
    userId: userId,
  });

  preuzeo = preuzeoKorisnik.fullname;
  }

  const article: Article = await this.article.findOne({
      articleId: data.articleId,
    });
    inv = data.invBroj;
    naziv = article.name;
    komentar = data.comment;
    try {
      const template = readFileSync(
        StorageConfig.prenosnica.template,
        /* StorageConfig.prenosnica.fullPath + 'templates/prenosnica.docx', */
      );
      const buffer = await createReport({
        template,
        data: {
          broj_prenosnice: documentNumber,
          predao_korisnik: predao,
          preuzeo_korisnik: preuzeo,
          inv_broj: inv,
          naziv: naziv,
          komentar: komentar,
        },
      });
      writeFileSync(
        StorageConfig.prenosnica.destination +
          'prenosnica' +
          documentNumber +
          '.docx',
        buffer,
      );
    } catch (err) {
      console.log(err);
    }
  }

  private async addArticleInResponsibility(
    user: number,
    data: AddEmployeArticleDto,
  ) {

    this.checkStock(data.articleId)
    
    let lastRecord = await this.document.findOne({
      order: {
        created_date: 'DESC'
      }
    })

    let currentYear = lastRecord ? new Date(lastRecord.created_date).getFullYear() : new Date().getFullYear();
    let documentNumber;

    if (currentYear === new Date().getFullYear()) {
        documentNumber = lastRecord ? lastRecord.documentNumber + 1 : 1;
    } else {
        documentNumber = 1;
        currentYear = new Date().getFullYear();
    }

    await this.createDocument('', '', '', '', '', user, data);

    const newDocument: Documents = new Documents();
    newDocument.path = 'prenosnica' + documentNumber + '.docx';
    newDocument.documentNumber = documentNumber;
    newDocument.articleId = data.articleId;

    const savedDocument = await this.document.save(newDocument);
    if (!savedDocument) {
      return new ApiResponse('error', -2020, 'Prenosnica nije kreirana');
    }

    const newUserArticleData: UserArticle = new UserArticle();
    newUserArticleData.documentId = savedDocument.documentsId;
    newUserArticleData.userId = user;
    newUserArticleData.serialNumber = data.serialNumber;
    newUserArticleData.invBroj = data.invBroj;
    newUserArticleData.articleId = data.articleId;
    newUserArticleData.value = data.value;
    newUserArticleData.comment = 'Zaduženje nove opreme';
    newUserArticleData.status = 'zaduženo';

    const savedUserArticle = await this.userArticle.save(newUserArticleData);
    if (!savedUserArticle) {
      return new ApiResponse(
        'error',
        -2021,
        'User Article ne može biti kreiran' /* Iako do ove greške teško da će doći */,
      );
    }

    const newArticleTimeline: ArticleTimeline = new ArticleTimeline();
        newArticleTimeline.documentId = savedDocument.documentsId;
        newArticleTimeline.userId = user;
        newArticleTimeline.serialNumber = data.serialNumber;
        newArticleTimeline.invBroj = data.invBroj;
        newArticleTimeline.articleId = data.articleId;
        newArticleTimeline.comment = data.comment;
        newArticleTimeline.status = "zaduženo"

    const savedArticleTimeline = await this.articleTimeline.save(newArticleTimeline)
      if (!savedArticleTimeline) {
        return new ApiResponse(
          'error',
          -2021,
          'Historija artikla nije spašena' /* Iako do ove greške teško da će doći */,
        );
      }

    const articleInStock: Stock = await this.stock.findOne({
      articleId: data.articleId,
    });

    await this.stock.remove(articleInStock); 
    const newArticleStock: Stock = await new Stock(); 
    newArticleStock.articleId = data.articleId;
    newArticleStock.valueOnConcract = articleInStock.valueOnConcract;
    newArticleStock.valueAvailable =
      articleInStock.valueAvailable - newUserArticleData.value;
    newArticleStock.sapNumber = articleInStock.sapNumber;
    await this.stock.save(newArticleStock);

    return await this.userArticle.findOne({
      where: { articleId: data.articleId },
      relations: ['article', 'user', 'document'],
    });

    /* FUNKCIJE */
  }

  private async checkStock(articleId: number){
    const checkArticleInStock: Stock = await this.stock.findOne({
      articleId: articleId,
    });

    if (!checkArticleInStock) {
      return new ApiResponse(
        'error',
        -2011,
        'Traženi artikal ne postoji u bazi podataka',
      );
    }

    if (checkArticleInStock.valueAvailable === 0) {
      return new ApiResponse(
        'error',
        -2005,
        'Na stanju više nema traženog artikla',
      );
    }
  }



  async getBySerialNumber(serialNumber: string): Promise<UserArticle | null> {
    const article = await this.userArticle.findOne({
      serialNumber: serialNumber,
    });
    if (article) {
      return article;
    }
    return null;
  }
}
