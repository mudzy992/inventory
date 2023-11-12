import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { TypeOrmCrudService } from '@nestjsx/crud-typeorm';
import { AddNewEmployeDto } from 'src/dtos/user/add.new.employe.dto';
import { User } from 'src/entities/User';
import { UserToken } from 'src/entities/UserToken';
import { ApiResponse } from 'src/misc/api.response.class';
import { Repository } from 'typeorm';
import * as crypto from 'crypto';
import { EditEmployeeDto } from 'src/dtos/user/edit.employee.dto';
/* import { DepartmentJob } from 'src/entities/DepartmentJob'; */

@Injectable()
export class UserService extends TypeOrmCrudService<User> {
  constructor(
    @InjectRepository(User)
    private readonly user: Repository<User>,
    @InjectRepository(UserToken)
    private readonly userToken: Repository<UserToken>,
/*     @InjectRepository(DepartmentJob)
    private readonly departmentJob: Repository<DepartmentJob>, */
  ) {
    super(user);
  }

  async createNewUser(data: AddNewEmployeDto): Promise<User | ApiResponse> {
    const passwordHash = crypto.createHash('sha512');
    passwordHash.update(data.password);
    const passwordHashString = passwordHash.digest('hex').toUpperCase();

    const newUser: User = new User();
    newUser.surname = data.surname;
    newUser.forname = data.forname;
    newUser.email = data.email;
    newUser.localNumber = data.localNumber;
    newUser.telephone = data.telephone;
    newUser.passwordHash = passwordHashString;
    newUser.departmentId = data.departmentId;
    newUser.jobId = data.jobId;
    newUser.locationId = data.locationId;

 /*    const newDepartmentJob: DepartmentJob = new DepartmentJob();
    newDepartmentJob.departmentId = data.departmentId;
    newDepartmentJob.jobId = data.jobId;
    newDepartmentJob.locationId = data.locationId;

    await this.departmentJob.save(newDepartmentJob) */

    try {
      const savedUser = await this.user.save(newUser);
      if (!savedUser) {
        throw new Error('');
      }
      return savedUser;
    } catch (e) {
      return new ApiResponse(
        'error',
        -6001,
        'This user account cannot be created.' + e.message,
      );
    }
  }

  async editUser(userId: number, data: EditEmployeeDto) {
    const passwordHash = crypto.createHash('sha512');
    passwordHash.update(data.password);
    const passwordHashString = passwordHash.digest('hex').toUpperCase();

    const existingUser = await this.user.findOne({where:{ userId : userId }})
    const fullname = data.surename + ' ' + data.forname;

    existingUser.forname = data.forname;
    existingUser.surname = data.surename;
    existingUser.fullname = fullname;
    existingUser.email = data.email;
    existingUser.passwordHash = passwordHashString;
    existingUser.localNumber = data.localNumber;
    existingUser.telephone = data.telephone;
    existingUser.jobId = data.jobId;
    existingUser.departmentId = data.departmentId;
    existingUser.locationId = data.locationId;
    existingUser.status = data.status;

    const saveEditedUser = await this.user.save(existingUser)
    if(!saveEditedUser){
      return new ApiResponse('error', -6002, 'Korisnik ne može biti izmjenjen')
    }
    }

  async getById(id) {
    return await this.user.findOne(
      {
        where: {userId: id},
        relations: ['department', 'job', 'location', 'articles.stock', 'articles.documents']
      }
    )
  }

  async getByEmail(email: string): Promise<User | null> {
    const user = await this.user.findOne(
      {
        where:{
          email: email,
        },
      });
    if (user) {
      return user;
    }
    return null;
  }
  async addToken(userId: number, token: string, expiresAt: string) {
    const userToken = new UserToken();
    userToken.userId = userId;
    userToken.token = token;
    userToken.expireAt = expiresAt;

    return await this.userToken.save(userToken);
  }

  async getUserToken(token: string): Promise<UserToken> {
    return await this.userToken.findOne({where:{
      token: token,
    }});
  }

  async invalidateToken(token: string): Promise<UserToken | ApiResponse> {
    const userToken = await this.userToken.findOne({where:{
      token: token,
    }});

    if (!userToken) {
      return new ApiResponse('error', -10001, 'No such refresh token!');
    }

    userToken.isValid = 0;

    await this.userToken.save(userToken);

    return await this.getUserToken(token);
  }

  async invalidateUserTokens(
    userId: number,
  ): Promise<(UserToken | ApiResponse)[]> {
    const userTokens = await this.userToken.find({where:{
      userId: userId,
    }});

    const results = [];

    for (const userToken of userTokens) {
      results.push(this.invalidateToken(userToken.token));
    }

    return results;
  }

}
