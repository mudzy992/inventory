import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { TypeOrmCrudService } from '@nestjsx/crud-typeorm';
import { AddNewLocationDto } from 'src/dtos/location/add.new.location.dto';
import { Location } from 'src/entities/Location';
import { ApiResponse } from 'src/misc/api.response.class';
import { Repository } from 'typeorm';

@Injectable()
export class LocationService extends TypeOrmCrudService<Location> {
  constructor(
    @InjectRepository(Location)
    private readonly location: Repository<Location>, //Čim spomenenom neki repozitorijum moramo da taj repozitoriju evidentiramo u našem osnovnom modulu (app.module.ts)
  ) {
    super(location);
  }
  async createNewLocation(data: AddNewLocationDto): Promise<Location | ApiResponse> {
    const newLocation: Location = new Location();
    newLocation.name = data.name;
    newLocation.code = data.code;
    newLocation.parentLocationId = data.parentLocationId;

    const savedLocation = await this.location.save(newLocation);

    if (!savedLocation) {
      return new ApiResponse('error', -4002, 'Lokacija nije sačuvana')
    }

    return await this.findOne(savedLocation.locationId, {
      relations: ['departmentJobs', 'locations'],
    })
  }
}
