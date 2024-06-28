import { Controller, Get, Post, Body, Param, Delete, Put, UseGuards } from '@nestjs/common';
import { CreateOrUpdateManyArticleFeaturesDto } from 'src/dtos/article.features/create.or.update.many.article.features.dto';
import { AllowToRoles } from 'src/misc/allow.to.roles.descriptor';
import { RoleCheckedGuard } from 'src/misc/role.checker.guard';
import { ArticleFeaturesService } from 'src/services/article.features/article.features.service';

@Controller('api/article-features')
export class ArticleFeaturesController {
  constructor(private readonly articleFeaturesService: ArticleFeaturesService) {}

  @Get()
  findAll() {
    return this.articleFeaturesService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.articleFeaturesService.findOne(+id);
  }

  @Post()
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles("administrator", "moderator")
  createOrUpdateMany(@Body() createOrUpdateManyArticleFeaturesDto: CreateOrUpdateManyArticleFeaturesDto) {
    return this.articleFeaturesService.createOrUpdateMany(createOrUpdateManyArticleFeaturesDto);
  }

  @Put()
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles("administrator", "moderator")
  updateMany(
    @Body() updateManyArticleFeaturesDto: CreateOrUpdateManyArticleFeaturesDto,
  ) {
    return this.articleFeaturesService.createOrUpdateMany(updateManyArticleFeaturesDto);
  }

  @Delete(':id')
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles("administrator", "moderator")
  remove(@Param('id') id: string) {
    return this.articleFeaturesService.remove(+id);
  }
}
