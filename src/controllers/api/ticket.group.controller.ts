import { Controller, Get, Param, UseGuards } from "@nestjs/common";
import { Crud } from "@nestjsx/crud";
import { TicketGroup } from "src/entities/TicketGroup";
import { AllowToRoles } from "src/misc/allow.to.roles.descriptor";
import { ApiResponse } from "src/misc/api.response.class";
import { RoleCheckedGuard } from "src/misc/role.checker.guard";
import { TicketGroupService } from "src/services/ticket.group/ticket.group.service";

@Controller("api/ticket/group")
@Crud({
  model: {
    type: TicketGroup,
  },
  params: {
    id: {
      field: "groupId",
      type: "number",
      primary: true,
    },
  },
  query: {
    join: {
        helpdeskTickets: {
        eager: true,
      },
        moderatorGroupMappings: {
        eager: true,
      },
        location: {
        eager: true,
      },
    },
  },
})
export class TicketGroupController {
  constructor(public service: TicketGroupService) {}
  
  @Get()
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles("administrator", "moderator")
  async getAllTickets(): Promise<TicketGroup[] | ApiResponse> {
    return await this.service.getAllTickets();
  }

  @Get("/user/:userId")
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles("administrator", "moderator")
  async getAllTicketsByUserLocation(@Param("userId") userId: number): Promise<TicketGroup[] | ApiResponse> {
    return await this.service.getAllTicketsByUserLocation(userId);
  }
}
