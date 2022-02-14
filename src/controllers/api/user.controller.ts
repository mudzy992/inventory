import { Body, Controller, Param, Post } from '@nestjs/common';
import { Crud } from '@nestjsx/crud';
import { AddEmployeArticleDto } from 'src/dtos/user/add.employe.article.dto';
import { AddNewEmployeDto } from 'src/dtos/user/add.new.employe.dto';
import { User } from 'src/entities/User';
import { ApiResponse } from 'src/misc/api.response.class';
import { UserService } from 'src/services/user/user.service';

@Controller('api/user')
@Crud({
  model: {
    type: User,
  },
  params: {
    id: {
      field: 'userId',
      type: 'number',
      primary: true,
    },
  },
  query: {
    join: {
      userArticles: {
        eager: true,
      },
      articles: {
        eager: true,
      },
    },
  },
})
export class UserController {
  constructor(public service: UserService) {}
  @Post('/createUser/')
  async createNewUser(
    @Body() data: AddNewEmployeDto,
  ): Promise<User | ApiResponse> {
    const email = await this.service.getByEmail(data.surename);
    if (email) {
      return new ApiResponse(
        'error',
        -2001,
        'Radnik već postoji u bazi podataka',
      );
    }
    return await this.service.createNewUser(data);
  }

  @Post('/responsibility/:id')
  async responsibilityArticleToUser (
    @Param('id') id: number,
    @Body() data: AddEmployeArticleDto,
  ) {
    return await this.service.addEmployeArticle(id, data);
  }
} /* Kraj koda */
