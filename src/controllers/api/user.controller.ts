import { Body, Controller, Param, Post } from '@nestjs/common';
import { Crud } from '@nestjsx/crud';
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
      articles: {
        eager: true,
      },
      responsibilityArticles: {
        eager: true,
      },
      debtItems: {
        eager: true,
      },
      destroyeds: {
        eager: true,
      },
    },
  },
})
export class UserController {
  constructor(public service: UserService) {}
  @Post('/add/')
  async createNewUser(
    @Body() data: AddNewEmployeDto,
  ): Promise<User | ApiResponse> {
    const email = await this.service.getByEmail(data.email);
    if (email) {
      return new ApiResponse(
        'error',
        -2001,
        'Radnik već postoji u bazi podataka',
      );
    }
    return await this.service.createNewUser(data);
  }
} /* Kraj koda */
