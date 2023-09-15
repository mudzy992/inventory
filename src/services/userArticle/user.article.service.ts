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
import { Responsibility } from 'src/entities/Responsibility';
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
    @InjectRepository(Responsibility)
    private readonly responsibility: Repository<Responsibility>,
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

        const respons: Responsibility = await this.responsibility.findOne({
          userArticleId: ua.userArticleId
        })

        await this.createDocument('', '', '', '', '', userId, data);
    
        const newDocument: Documents = new Documents();
        newDocument.path = 'prenosnica' + documentNumber + '.docx';
        newDocument.documentNumber = documentNumber;
        newDocument.articleId = data.articleId;
    
        const savedDocument = await this.document.save(newDocument);
        if (!savedDocument) {
          return new ApiResponse('error', -2020, 'Prenosnica nije kreirana');
        }

        if(respons){
          this.responsibility.update(respons, {
            documentId: savedDocument.documentsId,
            timestamp: ua.timestamp,
          })
        } else if (!respons){
          const newResponsibility: Responsibility = new Responsibility();
          newResponsibility.userArticleId = ua.userArticleId;
          newResponsibility.userId = ua.userId;
          newResponsibility.articleId = ua.articleId;
          newResponsibility.documentId = savedDocument.documentsId;
          newResponsibility.timestamp = ua.timestamp;
          newResponsibility.value = ua.value;
          newResponsibility.serialNumber = ua.serialNumber;
          newResponsibility.invBroj = ua.invBroj;
          newResponsibility.status = 'zaduženo';

          const savedResponsibility = await this.responsibility.save(newResponsibility);
          if (!savedResponsibility) {
            return new ApiResponse('error', -2020, 'Zaduženje nije kreirano');
          }
        }

        this.userArticle.update(ua, {
          documentId: savedDocument.documentsId,
          userId: userId,
          comment: data.comment,
        });

        await this.newArticleTimeline(
            savedDocument.documentsId,
            exResponsibility.userId,
            data.serialNumber,
            data.invBroj,
            data.articleId,
            data.comment,
            "razduženo"
          )

        await this.newArticleTimeline(
            savedDocument.documentsId,
            userId,
            data.serialNumber,
            data.invBroj,
            data.articleId,
            data.comment,
            "zaduženo"
          )
        
        return
      }
    } else if (exDebt) {
      const ua: UserArticle = await this.userArticle.findOne({
        userArticleId: exDebt.userArticleId,
      });

      this.checkStock(data.articleId)
 
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
        comment: "Zaduženje nove opreme 2",
      });

      await this.newArticleTimeline(
        savedDocument.documentsId,
        userId,
        data.serialNumber,
        data.invBroj,
        data.articleId,
        data.comment,
        "zaduženo"
        )
          
        const artStock: Stock = await this.stock.findOne({
          articleId: data.articleId,
        });
        this.stock.update(artStock, {
          valueAvailable: artStock.valueAvailable - 1,
        });

        if(exResponsibility){

          await this.newArticleTimeline(
            savedDocument.documentsId,
            exResponsibility.userId,
            data.serialNumber,
            data.invBroj,
            data.articleId,
            data.comment,
            "razduženo"
          )
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

    if(exResponsibility) {
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

      await this.newArticleTimeline(
              savedDocument.documentsId,
              exResponsibility.userId,
              data.serialNumber,
              data.invBroj,
              data.articleId,
              data.comment,
              "razduženo"
          )

      const resArticle: Responsibility = await this.responsibility.findOne({
        /*  userId: user, */
         serialNumber: data.serialNumber,
         articleId: data.articleId,
       });
       await this.responsibility.remove(resArticle);

      return await this.userArticle.findOne({
        where: { articleId: data.articleId },
        relations: ['article', 'user', 'document'],
      });
    }

    //U SLUČAJU DA IDE NA SKLADIŠTE TREBA POVEĆAVATI BROJ STOCK
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

      await this.newArticleTimeline(
        savedDocument.documentsId,
        exUserArticle.userId,
        data.serialNumber,
        data.invBroj,
        data.articleId,
        data.comment,
        "otpisano"
      )
      return await this.userArticle.findOne({
        where: { articleId: data.articleId },
        relations: ['article', 'user', 'document'],
      });
  }

  async newArticleTimeline (
    newDocumentId: number,
    newUserId: number,
    newSerilaNumber: string,
    newInvBroj: string,
    newArticleId: number,
    newComment: string,
    status: "zaduženo" | "razduženo" | "otpisano"
  ){
    const newArticleTimeline: ArticleTimeline = new ArticleTimeline();
        newArticleTimeline.documentId = newDocumentId;
        newArticleTimeline.userId = newUserId;
        newArticleTimeline.serialNumber = newSerilaNumber;
        newArticleTimeline.invBroj = newInvBroj;
        newArticleTimeline.articleId = newArticleId;
        newArticleTimeline.comment = newComment;
        newArticleTimeline.status = status

        await this.articleTimeline.save(newArticleTimeline)

        const savedArticleTimeline = await this.articleTimeline.save(newArticleTimeline)
      if (!savedArticleTimeline) {
        return new ApiResponse(
          'error',
          -2021,
          'Historija artikla nije spašena' /* Iako do ove greške teško da će doći */,
        );
      }
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
    newUserArticleData.comment = 'Zaduženje nove opreme 1';
    newUserArticleData.status = 'zaduženo';

    const savedUserArticle = await this.userArticle.save(newUserArticleData);
    if (!savedUserArticle) {
      return new ApiResponse(
        'error',
        -2021,
        'User Article ne može biti kreiran' /* Iako do ove greške teško da će doći */,
      );
    }

    await this.newArticleTimeline(
      savedDocument.documentsId,
      user,
      data.serialNumber,
      data.invBroj,
      data.articleId,
      data.comment,
      "zaduženo"
    )
    

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
