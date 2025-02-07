import { Body, Controller, Post, Put, Delete, Param, Get, UseGuards, Query } from "@nestjs/common";
import { Crud } from "@nestjsx/crud";
import { HelpdeskTickets } from "src/entities/HelpdeskTickets";
import { AllowToRoles } from "src/misc/allow.to.roles.descriptor";
import { ApiResponse } from "src/misc/api.response.class";
import { RoleCheckedGuard } from "src/misc/role.checker.guard";
import { HelpdeskTicketService } from "src/services/helpdesk.tickets/helpdesk.tickets.service";
import { AddNewTicketDto } from "src/dtos/helpdesk.tickets/add.ticket.dto";
import { EdiTicketDto } from "src/dtos/helpdesk.tickets/edit.ticket.dto";
import { HelpdeskTicketsDTO } from "src/dtos/helpdesk.tickets/helpdesk.tickets.dto";

@Controller("api/helpdesk")
@Crud({
  model: {
    type: HelpdeskTickets,
  },
  params: {
    id: {
      field: "ticketId",
      type: "number",
      primary: true,
    },
  },
  query: {
    join: {
      article: {
        eager: true,
      },
      assignedTo2: {
        eager: true,
      },
      group: {
        eager: true,
      },
      user: {
        eager: true,
      },
    },
  },
})
export class HelpdeskTicketsController {
  constructor(public service: HelpdeskTicketService) {}

  @Post()
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles("administrator", "moderator", "user")
  async addNewTicket(
    @Body() data: AddNewTicketDto
    ): Promise<HelpdeskTickets | ApiResponse> {
    const response = await this.service.addTicket(data);
    return response;
  }

  @Put(":id")
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles("administrator", "moderator")
  async editTicket(@Param("id") ticketId: number, @Body() editTicketDto: EdiTicketDto): Promise<ApiResponse> {
    return await this.service.editTicket(ticketId, editTicketDto);
  }

  @Delete(":id")
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles("administrator", "moderator")
  async deleteTicket(@Param("id") ticketId: number): Promise<ApiResponse> {
    return await this.service.deleteTicket(ticketId);
  }

  @Get("/ticket/:id")
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles("administrator", "moderator")
  async getTicketById(@Param("id") ticketId: number): Promise<HelpdeskTicketsDTO | ApiResponse> {
    return await this.service.getTicketById(ticketId);
  }

  @Get()
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles("administrator", "moderator")
  async getAllTickets(): Promise<HelpdeskTickets[] | ApiResponse> {
    return await this.service.getAllTickets();
  }

  @Get(":userId")
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles("administrator", "moderator")
  async getAllTicketsByGroupLocation(@Param("userId") userId: number): Promise<HelpdeskTickets[] | ApiResponse> {
    return await this.service.getAllTicketsByGroupLocation(userId);
  }

  @Get("/s/:userId")
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles("administrator", "moderator")
  async getAllTicketsByGroupLocationPagginedSearch(
    @Param("userId") userId: number,
    @Query("perPage") perPage: number = 10,
    @Query("page") page: number = 1,
    @Query("query") query: string = "",
    @Query("assignedTo") assignedTo?: number, 
    @Query("status") status?: string,
  ) {
    const offset = (page - 1) * perPage;
  
    return await this.service.getAllTicketsByGroupLocationPagginedSearch(
      userId, 
      perPage, 
      offset, 
      query,
      assignedTo,
      status
    );
  }
  

  @Get(":userId/user-tickets")
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles("administrator", "moderator")
  async getAllUserTickets(@Param("userId") userId: number): Promise<HelpdeskTicketsDTO[] | ApiResponse> {
    return await this.service.getByUserId(userId);
  }
}
