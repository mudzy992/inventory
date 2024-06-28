import { Injectable, NotFoundException } from "@nestjs/common";
import { InjectRepository } from "@nestjs/typeorm";
import { CreateOrUpdateManyArticleFeaturesDto } from "src/dtos/article.features/create.or.update.many.article.features.dto";
import { ArticleFeatures } from "src/entities/ArticleFeatures";
import { Repository } from "typeorm";

@Injectable()
export class ArticleFeaturesService {
  constructor(
    @InjectRepository(ArticleFeatures)
    private articleFeaturesRepository: Repository<ArticleFeatures>,
  ) {}

  findAll(): Promise<ArticleFeatures[]> {
    return this.articleFeaturesRepository.find({ relations: ['feature']});
  }

  async findOne(articleFeatureId: number): Promise<ArticleFeatures> {
    const articleFeature = await this.articleFeaturesRepository.findOne({where: {articleFeatureId: articleFeatureId}, relations:['feature']});
    if (!articleFeature) {
      throw new NotFoundException(`ArticleFeature #${articleFeatureId} not found`);
    }
    return articleFeature;
  }

  async createOrUpdateMany(createOrUpdateManyArticleFeaturesDto: CreateOrUpdateManyArticleFeaturesDto): Promise<ArticleFeatures[]> {
    const { features } = createOrUpdateManyArticleFeaturesDto;
    const articleFeatures = await Promise.all(
      features.map(async (dto) => {
        const existingFeature = await this.articleFeaturesRepository.findOne({
          where: { articleId: dto.articleId, featureId: dto.featureId },
        });

        if (existingFeature) {
          return this.articleFeaturesRepository.save({
            ...existingFeature,
            ...dto,
          });
        } else {
          const newFeature = this.articleFeaturesRepository.create(dto);
          return this.articleFeaturesRepository.save(newFeature);
        }
      }),
    );

    return articleFeatures;
  }

  async remove(id: number): Promise<void> {
    const articleFeature = await this.findOne(id);
    await this.articleFeaturesRepository.remove(articleFeature);
  }
}
