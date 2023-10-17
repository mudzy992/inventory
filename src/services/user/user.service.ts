import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { TypeOrmCrudService } from '@nestjsx/crud-typeorm';
import { User } from 'src/entities/User';
import { UserToken } from 'src/entities/UserToken';
import { Repository } from 'typeorm';
import { AddNewEmployeDto } from 'src/dtos/user/add.new.employe.dto';
import { EditEmployeeDto } from 'src/dtos/user/edit.employee.dto';
import * as crypto from 'crypto';
import { ApiResponse } from 'src/misc/api.response.class';

@Injectable()
export class UserService extends TypeOrmCrudService<User> {
  constructor(
    @InjectRepository(User)
    private readonly user: Repository<User>,
    @InjectRepository(UserToken)
    private readonly userToken: Repository<UserToken>,
  ) {
    super(user);
  }

  async createNewUser(data: AddNewEmployeDto): Promise<User | ApiResponse> {
    // Provjeri postoji li korisnik s istim e-mailom
    const existingUser = await this.user.findOne({ where: { email: data.email } });
    if (existingUser) {
      return new ApiResponse('error', -6001, 'Korisnik s istim e-mailom već postoji.');
    }

    // Hashiraj lozinku
    const passwordHash = crypto.createHash('sha512');
    passwordHash.update(data.password);
    const passwordHashString = passwordHash.digest('hex').toUpperCase();

    const newUser: User = this.user.create({
      forname: data.forname,
      surname: data.surename,
      email: data.email,
      localNumber: data.localNumber,
      telephone: data.telephone,
      passwordHash: passwordHashString,
      departmentId: data.departmentId,
      jobId: data.jobId,
      locationId: data.locationId,
    });

    try {
      const savedUser = await this.user.save(newUser);
      return savedUser;
    } catch (e) {
      return new ApiResponse('error', -6002, 'Korisnički račun ne može biti stvoren.');
    }
  }

  async editUser(userId: number, data: EditEmployeeDto) {
    // Provjeri postoji li korisnik s navedenim ID-om
    const existingUser = await this.user.findOne({ where: { userId } });
    if (!existingUser) {
      return new ApiResponse('error', -6003, 'Korisnik nije pronađen.');
    }

    // Hashiraj lozinku
    const passwordHash = crypto.createHash('sha512');
    passwordHash.update(data.password);
    const passwordHashString = passwordHash.digest('hex').toUpperCase();

    // Ažuriraj korisnika s novim podacima
    this.user.merge(existingUser, {
      forname: data.forname,
      surname: data.surename,
      email: data.email,
      passwordHash: passwordHashString,
      localNumber: data.localNumber,
      telephone: data.telephone,
      jobId: data.jobId,
      departmentId: data.departmentId,
      locationId: data.locationId,
    });

    const saveEditedUser = await this.user.save(existingUser);

    if (!saveEditedUser) {
      return new ApiResponse('error', -6004, 'Korisnik ne može biti uređen. Pokušajte ponovno kasnije.');
    }
  }

  async getById(id) {
    return await this.user.findOne(id);
  }

  async getByEmail(email: string): Promise<User | null> {
    const user = await this.user.findOne({ where: { email } });
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
    return await this.userToken.findOne({ where: { token } });
  }

  async invalidateToken(token: string): Promise<UserToken | ApiResponse> {
    const userToken = await this.userToken.findOne({ where: { token } });

    if (!userToken) {
      return new ApiResponse('error', -10001, 'Nema takvog osvježavajućeg tokena!');
    }

    userToken.isValid = 0;

    await this.userToken.save(userToken);

    return await this.getUserToken(token);
  }

  async invalidateUserTokens(userId: number): Promise<(UserToken | ApiResponse)[]> {
    const userTokens = await this.userToken.find({ where: { userId } });

    const results = [];

    for (const userToken of userTokens) {
      results.push(this.invalidateToken(userToken.token));
    }

    return results;
  }
}
