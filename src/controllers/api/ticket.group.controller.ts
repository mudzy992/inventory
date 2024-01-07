import { Controller, Get, Param, Query, UseGuards } from "@nestjs/common";
import { Crud } from "@nestjsx/crud";
import { HelpdeskTicketsDTO } from "src/dtos/helpdesk.tickets/helpdesk.tickets.dto";
import { TicketGroupDTO } from "src/dtos/ticket.group/ticket.group.dto";
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
        categories: {
        eager: true,
      },
        helpdeskTickets: {
        eager: true,
      },
        helpdeskTickets2: {
        eager: true,
      },
        moderatorGroupMappings: {
        eager: true,
      },
        parentGroup: {
        eager: true,
      },
        ticketGroups: {
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
  @AllowToRoles("administrator", "moderator", "user")
  async getAllGroups(): Promise<TicketGroup[] | ApiResponse> {
    return await this.service.getAllGroups();
  }
  
  @Get("/tikets")
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles("administrator", "moderator")
  async getAllTickets(): Promise<TicketGroup[] | ApiResponse> {
    return await this.service.getAllTickets();
  }

  @Get("/parent/:groupId")
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles("administrator", "moderator", "user")
  async getGroupByParentGroupId(@Param("groupId") groupId: number): Promise<TicketGroup[] | ApiResponse> {
    return await this.service.getGroupByParentGroupId(groupId);
  }
}
