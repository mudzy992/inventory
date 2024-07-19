import { Injectable } from "@nestjs/common";
import { InjectRepository } from "@nestjs/typeorm";
import { TypeOrmCrudService } from "@nestjsx/crud-typeorm";
import { OrganizationDTO } from "src/dtos/organization/organization.dto";
import { Organization } from "src/entities/Organization";
import { ApiResponse } from "src/misc/api.response.class";
import { Repository } from "typeorm";

@Injectable()
export class OrganizationService extends TypeOrmCrudService<Organization> {
  constructor(
    @InjectRepository(Organization)
    private readonly organization: Repository<Organization>
  ) {
    super(organization);
  }

  async getAllOrganizations(): Promise<OrganizationDTO[] | ApiResponse> {
    const organizationData = await this.organization.find()
    const response: OrganizationDTO[] = await organizationData.map((item) => ({
      organizationId: item.organizationId,
      name: item.name,
    }))

    if(response){
      return response
    }
    return new ApiResponse("error", -4003, "Lista organizacija nije pronađena");
  }

/*   async createNewOrganization(
    data: AddNewLocationDto
  ): Promise<Location | ApiResponse> {
    const newLocation: Location = new Location();
    newLocation.name = data.name;
    newLocation.code = data.code;
    newLocation.parentLocationId = data.parentLocationId;

    const savedLocation = await this.location.save(newLocation);

    if (!savedLocation) {
      return new ApiResponse("error", -4002, "Lokacija nije sačuvana");
    }

    return await this.findOne({
      where: { locationId: savedLocation.locationId },
      relations: ["departmentJobs", "locations"],
    });
  } */
}
