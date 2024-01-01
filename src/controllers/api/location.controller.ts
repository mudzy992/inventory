import { Body, Controller, Get, Post, UseGuards } from "@nestjs/common";
import { Crud } from "@nestjsx/crud";
import { AddNewLocationDto } from "src/dtos/location/add.new.location.dto";
import { LocationDTO } from "src/dtos/location/location.dto";
import { Location } from "src/entities/Location";
import { AllowToRoles } from "src/misc/allow.to.roles.descriptor";
import { ApiResponse } from "src/misc/api.response.class";
import { RoleCheckedGuard } from "src/misc/role.checker.guard";
import { LocationService } from "src/services/location/location.service";

@Controller("api/location")
@Crud({
  model: {
    type: Location,
  },
  params: {
    id: {
      field: "locationId",
      type: "number",
      primary: true,
    },
  },
  query: {
    join: {
      departmentJobs: {
        eager: true,
      },
      locations: {
        eager: true,
      },
      users: {
        eager: true,
      },
    },
  },
})
export class LocationController {
  constructor(public service: LocationService) {}
  
  @Get()
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles("administrator", "moderator")
  async getAllLocation(): Promise<LocationDTO[] | ApiResponse>
  {
    return await this.service.getAllLocation()
  }

  @Post()
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles("administrator", "moderator")
  async createNewLocation(
    @Body() data: AddNewLocationDto
  ): Promise<Location | ApiResponse> {
    return await this.service.createNewLocation(data);
  }
}
