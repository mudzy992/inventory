import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Administrator } from 'src/entities/Administrator';
import { Repository } from 'typeorm';
import * as crypto from 'crypto';
import { ApiResponse } from 'src/misc/api.response.class';
import { AddAdministratorDto } from 'src/dtos/administrator/add.administrator.dto';
import { EditAdministratorDto } from './edit.administrator.dto';
import { AdministratorToken } from 'src/entities/AdministratorToken';

@Injectable()
export class AdministratorService {
  constructor(
    @InjectRepository(Administrator)
    private readonly administrator: Repository<Administrator>,
    @InjectRepository(AdministratorToken)
    private readonly administratorToken: Repository<AdministratorToken>,
  ) {}
  getAll(): Promise<Administrator[]> {
    return this.administrator.find();
  }

  async getByUsername(username: string): Promise<Administrator | null> {
    const admin = await this.administrator.findOne({
      username: username,
    });
    if (admin) {
      return admin;
    }
    return null;
  }

  getById(id: number): Promise<Administrator> {
    return this.administrator.findOne(id);
  }

  add(data: AddAdministratorDto): Promise<Administrator | ApiResponse> {
    const passwordHash = crypto.createHash('sha512');
    passwordHash.update(data.password);
    const passwordHashString = passwordHash.digest('hex').toUpperCase();
    const newAdmin: Administrator = new Administrator();
    newAdmin.username = data.username;
    newAdmin.passwordHash = passwordHashString;
    return new Promise((resolve) => {
      this.administrator
        .save(newAdmin)
        .then((data) => resolve(data))
        .catch((error) => {
          const response: ApiResponse = new ApiResponse('error', -8001);
          resolve(response);
        });
    });
  }

  async editById(
    id: number,
    data: EditAdministratorDto,
  ): Promise<Administrator | ApiResponse> {
    const admin: Administrator = await this.administrator.findOne(id);
    if (admin === undefined) {
      return new Promise((resolve) => {
        resolve(new ApiResponse('error', -8002));
      });
    }
    const passwordHash = crypto.createHash('sha512');
    passwordHash.update(data.password);
    const passwordHashString = passwordHash.digest('hex').toUpperCase();
    admin.passwordHash = passwordHashString;
    return this.administrator.save(admin);
  }
  async addToken(administratorId: number, token: string, expiresAt: string) {
    const administratorToken = new AdministratorToken();
    administratorToken.administratorId = administratorId;
    administratorToken.token = token;
    administratorToken.expireAt = expiresAt;

    return await this.administratorToken.save(administratorToken);
  }

  async getAdministratorToken(token: string): Promise<AdministratorToken> {
    return await this.administratorToken.findOne({
      token: token,
    });
  }

  async invalidateToken(
    token: string,
  ): Promise<AdministratorToken | ApiResponse> {
    const administratorToken = await this.administratorToken.findOne({
      token: token,
    });
    if (!administratorToken) {
      return new ApiResponse('error', -10001, 'Neispravan osvježavajući token');
    }
    administratorToken.isValid = 0;
    await this.administratorToken.save(administratorToken);
    return await this.getAdministratorToken(token);
  }

  async invalidateAdministratorTokens(
    administratorId: number,
  ): Promise<(AdministratorToken | ApiResponse)[]> {
    const administratorTokens = await this.administratorToken.find({
      administratorId: administratorId,
    });
    const results = [];
    for (const administratorToken of administratorTokens) {
      results.push(this.invalidateToken(administratorToken.token));
    }
    return results;
  }
} /* Kraj koda */
