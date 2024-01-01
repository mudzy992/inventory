import { Controller, Get, UseGuards } from "@nestjs/common";
import { Crud } from "@nestjsx/crud";
import { ModeratorGroupMappingDTO } from "src/dtos/moderator.group.mapping/moderator.group.mapping.dto";
import { ModeratorGroupMapping } from "src/entities/ModeratorGroupMapping";
import { AllowToRoles } from "src/misc/allow.to.roles.descriptor";
import { ApiResponse } from "src/misc/api.response.class";
import { RoleCheckedGuard } from "src/misc/role.checker.guard";
import { ModeratorGroupMappingService } from "src/services/moderator.group.mapping/moderator.group.mapping";

@Controller("api/moderator/group")
@Crud({
  model: {
    type: ModeratorGroupMapping,
  },
  params: {
    id: {
      field: "mappingId",
      type: "number",
      primary: true,
    },
  },
  query: {
    join: {
        group: {
        eager: true,
      },
        user: {
        eager: true,
      },
    },
  },
})
export class ModeratorGroupMappingController {
  constructor(public service: ModeratorGroupMappingService) {}
  
  @Get()
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles("administrator", "moderator")
  async getAllTickets(): Promise<ModeratorGroupMappingDTO[] | ApiResponse> {
    return await this.service.getAllGroupModerators();
  }
}
