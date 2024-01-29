import { Injectable } from "@nestjs/common";
import { InjectRepository } from "@nestjs/typeorm";
import { TypeOrmCrudService } from "@nestjsx/crud-typeorm";
import { ArticleTimelineDTO } from "src/dtos/article.timeline/article.timeline.dto";
import { ArticleTimeline } from "src/entities/ArticleTimeline";
import { ApiResponse } from "src/misc/api.response.class";
import PaginatedArticleTimelineType from "src/types/paggined.article.timeline.type";
import { Repository } from "typeorm";

@Injectable()
export class ArticleTimelineService extends TypeOrmCrudService<ArticleTimeline> {
  constructor(
    @InjectRepository(ArticleTimeline)
    private readonly articleTimelineRepository: Repository<ArticleTimeline>
  ) {
    super(articleTimelineRepository);
  }

  async getBySerialNumber(
    serialNumber: string
  ): Promise<ArticleTimeline[] | null> {
    const serialnumber = await this.articleTimelineRepository.find({
      where: { serialNumber: serialNumber },
    });
    if (serialnumber) {
      return serialnumber;
    }
    return null;
  }

  async getById(id): Promise<ArticleTimelineDTO | ApiResponse> {
    const articleTimlineData = await this.articleTimelineRepository.findOne({
      where: { articleTimelineId: id },
      relations: ["article", "article.stock", "user", "subbmited", "document"],
    });
    
    const response: ArticleTimelineDTO = {
      invNumber: articleTimlineData.invNumber,
      user: {
        gender: articleTimlineData.user.gender,
        fullname: articleTimlineData.user.fullname,
      },
      subbmited: {
        gender: articleTimlineData.subbmited.gender,
        fullname: articleTimlineData.subbmited.fullname,
      },
      article: {
        stock: {
          name: articleTimlineData.article.stock.name,
        }
      }
    }
    if(response){
      return response
    }
    return new ApiResponse("error", -11000, "Vremenska linija nije pronađena!")
  }

  async getAll() {
    return await this.articleTimelineRepository.find({
      relations: ["article", "user", "subbmited", "document"],
    });
  }

  async findPaginatedArticlesTimeline(
    id: number,
    perPage: number,
    offset: number
  ): Promise<PaginatedArticleTimelineType> {
    const [results, totalResults] =
      await this.articleTimelineRepository.findAndCount({
        where: { articleId: id },
        take: perPage,
        skip: offset,
        relations: ["article", "document", "user", "subbmited"],
      });

    return {
      results,
      total: totalResults,
    };
  }
}
