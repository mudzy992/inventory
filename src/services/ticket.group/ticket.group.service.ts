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

  async getAllGroups(): Promise<TicketGroupDTO[] | ApiResponse> {
    const groups = await this.ticketGroup.find({relations:["location", "ticketGroups", "ticketGroups.location", "moderatorGroupMappings", "moderatorGroupMappings.user"]})

    const response: TicketGroupDTO[] = groups.map((group) => ({
      groupId: group.groupId,
      groupName: group.groupName,
      location: group.location,
      parentGroupId: group.parentGroupId,
      ticketGroups: (group.ticketGroups || []).map((parent) => ({
        groupId: parent.groupId,
        parentGroupId: parent.parentGroupId,
        groupName: parent.groupName,
        location: parent.location,
      })),
      moderatorGroupMappings: (group.moderatorGroupMappings || []).map((moderator) => ({
        mappingId: moderator.mappingId,
        userId: moderator.userId,
        groupId: moderator.groupId,
        user: {
          userId: moderator.user.userId,
          fullname: moderator.user.fullname,
          email: moderator.user.email,
        }
      }))
    }))

    if(!response) {
      return new ApiResponse('error', -11002, 'Groups not found.');
    }

    return response
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

}
