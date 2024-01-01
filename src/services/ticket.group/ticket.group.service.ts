import { Injectable } from "@nestjs/common";
import { InjectRepository } from "@nestjs/typeorm";
import { TypeOrmCrudService } from "@nestjsx/crud-typeorm";
import { TicketGroupDTO } from "src/dtos/ticket.group/ticket.group.dto";
import { TicketGroup } from "src/entities/TicketGroup";
import { User } from "src/entities/User";
import { ApiResponse } from "src/misc/api.response.class";
import { Repository } from "typeorm";

@Injectable()
export class TicketGroupService extends TypeOrmCrudService<TicketGroup> {
  constructor(
    @InjectRepository(TicketGroup)
    private readonly ticketGroup: Repository<TicketGroup>,
    @InjectRepository(User)
    private readonly user: Repository<User>
  ) {
    super(ticketGroup);
  }

  async getGroupByParentGroupId(groupId: number): Promise<TicketGroup[] | ApiResponse> {
    const ticket = await this.ticketGroup.find({where: {parentGroupId: groupId }})

    if(!ticket) {
      return new ApiResponse('error', -11002, 'Ticket not found.');
    }

    return ticket
  }

  async getAllTickets(): Promise<TicketGroup[] | ApiResponse> {
    const ticket = await this.ticketGroup.find({
        relations: [
            "location",
            "moderatorGroupMappings",
            "helpdeskTickets", 
            "helpdeskTickets.user", 
            "helpdeskTickets.article.stock"]
    });
  
    if (!ticket) {
      return new ApiResponse('error', -11002, 'Ticket not found.');
    }
    return ticket;
  }

  async getAllTicketsByUserLocation(userId:number): Promise<TicketGroupDTO[] | ApiResponse> {
    const user = await this.user.findOne({where: {userId: userId}, relations:["location"]})
    const ticket = await this.ticketGroup.find({
        where: { location: { locationId: user.location.parentLocationId }},
        relations: [
            "location",
            "helpdeskTickets",
            "helpdeskTickets.group",
            "helpdeskTickets.user",
            "helpdeskTickets.assignedTo2", 
            "helpdeskTickets.article.stock"]
    });    
  
    if (!ticket) {
      return new ApiResponse('error', -11002, 'Ticket not found.');
    }
    return ticket;
  }
}
