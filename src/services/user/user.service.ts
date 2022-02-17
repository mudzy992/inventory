import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { TypeOrmCrudService } from '@nestjsx/crud-typeorm';
import { AddNewEmployeDto } from 'src/dtos/user/add.new.employe.dto';
import { User } from 'src/entities/User';
import { ApiResponse } from 'src/misc/api.response.class';
import { Repository } from 'typeorm';

@Injectable()
export class UserService extends TypeOrmCrudService<User> {
  constructor(
    @InjectRepository(User)
    private readonly user: Repository<User>,
  ) {
    super(user);
  }

  async createNewUser(data: AddNewEmployeDto): Promise<User | ApiResponse> {
    const newUser: User = new User();
    newUser.surname = data.surename;
    newUser.forname = data.forname;
    newUser.jobTitle = data.job;
    newUser.department = data.department;
    newUser.location = data.location;

    const savedUser = await this.user.save(newUser);
    if (!savedUser) {
      return new ApiResponse('error', -2001, 'Radnik ne može biti dodan');
    }

    return await this.findOne(savedUser.userId, {
      relations: ['userArticles'],
    });
  }

  /* IZMJENA DETALJA RADNIKA MEHANIZAM - implementirati */
  /* Uraditi pravi getByEmail jer u bazi nema email polja */

  async getByEmail(email: string): Promise<User | null> {
    /* Mehanizam pronalaženja artikla u skladištu po sap broju */
    const user = await this.user.findOne({ surname: email });
    if (user) {
      return user;
    }
    return null;
  }
} /* KRAJ KODA */
