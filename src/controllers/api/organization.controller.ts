import { Body, Controller, Get, UseGuards } from "@nestjs/common";
import { Crud } from "@nestjsx/crud";
import { OrganizationDTO } from "src/dtos/organization/organization.dto";
import { Organization } from "src/entities/Organization";
import { AllowToRoles } from "src/misc/allow.to.roles.descriptor";
import { ApiResponse } from "src/misc/api.response.class";
import { RoleCheckedGuard } from "src/misc/role.checker.guard";
import { OrganizationService } from "src/services/organization/organization.service";

@Controller("api/organization")
@Crud({
  model: {
    type: Organization,
  },
  params: {
    id: {
      field: "organizationId",
      type: "number",
      primary: true,
    },
  },
  query: {
    join: {
      users: {
        eager: true,
      },
    },
  },
})
export class OrganizationController {
  constructor(public service: OrganizationService) {}
  
  @Get()
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles("administrator", "moderator", "user")
  async getAllLOrganization(): Promise<OrganizationDTO[] | ApiResponse>
  {
    return await this.service.getAllOrganizations()
  }

/*   @Post()
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles("administrator", "moderator")
  async createNewLocation(
    @Body() data: AddNewLocationDto
  ): Promise<Location | ApiResponse> {
    return await this.service.createNewLocation(data);
  } */
}
