import { Injectable, HttpException, HttpStatus } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import * as crypto from 'crypto';
import { ApiResponse } from 'src/misc/api.response.class';
import { AddAdministratorDto } from 'src/dtos/administrator/add.administrator.dto';
import { EditAdministratorDto } from './edit.administrator.dto';
import { AdministratorToken } from 'src/entities/AdministratorToken';
import { Administrator } from 'src/entities/Administrator';

@Injectable()
export class AdministratorService {
  constructor(
    @InjectRepository(Administrator)
    private readonly administrator: Repository<Administrator>,
    @InjectRepository(AdministratorToken)
    private readonly administratorToken: Repository<AdministratorToken>,
  ) {}

  async getAll(): Promise<Administrator[]> {
    return await this.administrator.find();
  }

  async getByUsername(username: string): Promise<Administrator | null> {
    return await this.administrator.findOne({ where: { username: username } });
  }

  async getById(id: number): Promise<Administrator> {
    return await this.administrator.findOne({where:{administratorId:id}});
  }

  async add(data: AddAdministratorDto): Promise<Administrator | ApiResponse> {
    try {
      const passwordHash = crypto
        .createHash('sha512')
        .update(data.password)
        .digest('hex')
        .toUpperCase();

      const newAdmin: Administrator = this.administrator.create({
        username: data.username,
        passwordHash: passwordHash,
      });

      return await this.administrator.save(newAdmin);
    } catch (error) {
      const response: ApiResponse = new ApiResponse('error', -8001);
      throw new HttpException(response, HttpStatus.BAD_REQUEST);
    }
  }

  async editById(id: number, data: EditAdministratorDto): Promise<Administrator | ApiResponse> {
    const admin: Administrator = await this.administrator.findOne({where:{administratorId:id}});
    if (!admin) {
      const response: ApiResponse = new ApiResponse('error', -8002);
      throw new HttpException(response, HttpStatus.NOT_FOUND);
    }

    const passwordHash = crypto
      .createHash('sha512')
      .update(data.password)
      .digest('hex')
      .toUpperCase();

    admin.passwordHash = passwordHash;

    return await this.administrator.save(admin);
  }

  async addToken(administratorId: number, token: string, expiresAt: string) {
    const administratorToken = this.administratorToken.create({
      administratorId,
      token,
      expireAt: expiresAt,
    });

    return await this.administratorToken.save(administratorToken);
  }

  async getAdministratorToken(token: string): Promise<AdministratorToken> {
    return await this.administratorToken.findOne({ where: { token: token } });
  }

  async invalidateToken(token: string): Promise<AdministratorToken | ApiResponse> {
    const administratorToken = await this.administratorToken.findOne({ where: { token: token } });

    if (!administratorToken) {
      const response: ApiResponse = new ApiResponse('error', -10001, 'Neispravan osvježavajući token');
      throw new HttpException(response, HttpStatus.BAD_REQUEST);
    }

    administratorToken.isValid = 0;
    await this.administratorToken.save(administratorToken);

    return administratorToken;
  }

  async invalidateAdministratorTokens(administratorId: number): Promise<(AdministratorToken | ApiResponse)[]> {
    const administratorTokens = await this.administratorToken.find({ where: { administratorId: administratorId } });

    const results: (AdministratorToken | ApiResponse)[] = [];

    for (const administratorToken of administratorTokens) {
      results.push(await this.invalidateToken(administratorToken.token));
    }

    return results;
  }
}
