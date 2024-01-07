import { Injectable } from "@nestjs/common";
import { InjectRepository } from "@nestjs/typeorm";
import { TypeOrmCrudService } from "@nestjsx/crud-typeorm";
import { AddNewTicketDto } from "src/dtos/helpdesk.tickets/add.ticket.dto";
import { EdiTicketDto } from "src/dtos/helpdesk.tickets/edit.ticket.dto";
import { HelpdeskTicketsDTO } from "src/dtos/helpdesk.tickets/helpdesk.tickets.dto";
import { HelpdeskTickets } from "src/entities/HelpdeskTickets";
import { User } from "src/entities/User";
import { ApiResponse } from "src/misc/api.response.class";
import { Brackets, Repository } from "typeorm";

@Injectable()
export class HelpdeskTicketService extends TypeOrmCrudService<HelpdeskTickets> {
  constructor(
    @InjectRepository(HelpdeskTickets)
    private readonly helpDeskTickets: Repository<HelpdeskTickets>,
    @InjectRepository(User)
    private readonly user: Repository<User>
  ) {
    super(helpDeskTickets);
  }

  async addTicket(data: AddNewTicketDto): Promise<HelpdeskTickets | ApiResponse> {
    const newTicket: HelpdeskTickets = new HelpdeskTickets();
    newTicket.userId = data.userId;
    newTicket.articleId = data.articleId;
    newTicket.groupId = data.groupId;
    newTicket.groupPartentId = data.groupPartentId;
    newTicket.description = data.description;
    newTicket.clientDuoDate = data.clientDuoDate;

    try {
        const savedTicket = await this.helpDeskTickets.save(newTicket);
        const response = new ApiResponse('success', -11000, 'Ticket added successfully.');
        return await this.findOne({
            where: { ticketId: savedTicket.ticketId },
            relations: ["article", "assignedTo2", "group", "user"],
        });
    } catch (error) {
        return new ApiResponse('error', -11001, 'Failed to add ticket.' + error.message);
    }
    
  }

  async editTicket(ticketId: number, editTicketDto: EdiTicketDto): Promise<ApiResponse> {
    const existingTicket = await this.helpDeskTickets.findOne({where: {ticketId: ticketId}});
  
    if (!existingTicket) {
      return new ApiResponse('error', -11002, 'Ticket not found.');
    }
  
    // Ažurirajte atribute tiketa na osnovu DTO objekta
    existingTicket.groupId = editTicketDto.groupId;
    existingTicket.resolveDescription = editTicketDto.resolveDescription;
    existingTicket.duoDate = editTicketDto.duoDate;
    existingTicket.resolveDate = editTicketDto.resolveDate;
    existingTicket.resolveTimespand = editTicketDto.resolveTimespand;
    existingTicket.assignedTo = editTicketDto.assignedTo;
    existingTicket.status = editTicketDto.status;
    existingTicket.priority = editTicketDto.priority;
    existingTicket.resolveResolution = editTicketDto.resolveResolution;
  
    try {
      await this.helpDeskTickets.save(existingTicket);
      return new ApiResponse('success', -11003, 'Ticket edited successfully.');
    } catch (error) {
      return new ApiResponse('error', -11004, 'Failed to edit ticket.' + error);
    }
  }

  async deleteTicket(ticketId: number): Promise<ApiResponse> {
    const existingTicket = await this.helpDeskTickets.findOne({where: {ticketId: ticketId}});
  
    if (!existingTicket) {
      return new ApiResponse('error', -11002, 'Ticket not found.');
    }
  
    try {
      await this.helpDeskTickets.remove(existingTicket);
      return new ApiResponse('success',-11005, 'Ticket deleted successfully.');
    } catch (error) {
      return new ApiResponse('error',-11006, 'Failed to delete ticket.');
    }
  }

  async getTicketById(ticketId: number): Promise<HelpdeskTicketsDTO | ApiResponse> {
    const ticket = await this.helpDeskTickets.findOne({
        where: {ticketId: ticketId},
        relations: [
        "user",
        "user.department",
        "user.location", 
        "group", 
        "groupPartent", 
        "assignedTo2", 
        "article", 
        "article.stock"]});
    
    const response: HelpdeskTicketsDTO = {
      ticketId: ticket.ticketId,
      articleId: ticket.articleId,
      userId: ticket.userId,
      description: ticket.description,
      createdAt: ticket.createdAt,
      duoDate: ticket.duoDate,
      clientDuoDate: ticket.clientDuoDate,
      assignedTo: ticket.assignedTo,
      groupId: ticket.groupId,
      resolveDescription: ticket.resolveDescription,
      resolveDate: ticket.resolveDate,
      resolveResolution: ticket.resolveResolution,
      resolveTimespand: ticket.resolveTimespand,
      status: ticket.status,
      priority: ticket.priority,
      user: {
        fullname: ticket.user.fullname,
        localNumber: ticket.user.localNumber,
        department: {
          title: ticket.user.department.title,
        },
        location: {
          name: ticket.user.location.name,
        },
      },
      assignedTo2:{
        fullname: ticket.assignedTo2 ? ticket.assignedTo2.fullname : null,
      },
      article: {
        invNumber: ticket.article.invNumber,
        serialNumber: ticket.article.serialNumber,
        stock: {
          name: ticket.article.stock.name,
        }
      },
      group: ticket.group,
      groupPartent: ticket.groupPartent,
    }
  
    if (!response) {
      return new ApiResponse('error', -11002, 'Ticket not found.');
    }
  
    return response;
  }

  async getAllTickets(): Promise<HelpdeskTickets[] | ApiResponse> {
    const ticket = await this.helpDeskTickets.find({
        relations: ["user", "group", "assignedTo2", "article", "article.stock"]
    });
  
    if (!ticket) {
      return new ApiResponse('error', -11002, 'Ticket not found.');
    }
  
    return ticket;
  }

  async getAllTicketsByGroupLocation(userId: number): Promise<HelpdeskTickets[] | ApiResponse> {
    const user = await this.user.findOne({where: {userId: userId}, relations:["location"]})
    const ticket = await this.helpDeskTickets.find({
        where: { group: { locationId: user.location.parentLocationId }},
        relations: ["user", "group", "assignedTo2", "article", "article.stock"]
    });
  
    if (!ticket) {
      return new ApiResponse('error', -11002, 'Ticket not found.');
    }
  
    return ticket;
  }

  async getAllTicketsByGroupLocationPagginedSearch(
    userId: number,
    perPage: number,
    offset: number,
    query: string,
    assignedTo?: number | null,
    status?: string
  ) {
    const user = await this.user.findOne({ where: { userId: userId }, relations: ["location"] });
    const ticketsQuery = this.helpDeskTickets
      .createQueryBuilder("ticket")
      .leftJoin("ticket.user", "user")
      .leftJoin("ticket.group", "group")
      .leftJoin("ticket.assignedTo2", "assignedTo2")
      .leftJoin("ticket.article", "article")
      .leftJoin("article.stock", "stock")
      .where("group.locationId = :locationId", { locationId: user.location.parentLocationId })
      .select(["ticket", "user", "group", "assignedTo2", "article", "stock"])
      .take(perPage)
      .skip(offset)
      .orderBy('ticket.createdAt', 'DESC');
  
    if (query) {
      ticketsQuery.andWhere(
        new Brackets((qb) => {
          qb.where("user.fullname LIKE :query", { query: `%${query}%` });
          qb.orWhere("ticket.description LIKE :query", { query: `%${query}%` });
          qb.orWhere("article.serialNumber LIKE :query", { query: `%${query}%` });
          qb.orWhere("article.invNumber LIKE :query", { query: `%${query}%` });
          qb.orWhere("article.status LIKE :query", { query: `%${query}%` });
          qb.orWhere("group.groupName LIKE :query", { query: `%${query}%` });
        })
      );
    }
/* 
    console.log(assignedTo)
    console.log(status)
    if (assignedTo !== undefined && assignedTo !== null) {
      ticketsQuery.andWhere("ticket.assignedTo = :assignedTo", { assignedTo });
    } else if (assignedTo === null) {
      ticketsQuery.andWhere("ticket.assignedTo = :assignedTo", { assignedTo });
    }
  
    if (status !== undefined) {
      ticketsQuery.andWhere("ticket.status = :status", { status });
    }

     */
  
    const [results, totalResults] = await ticketsQuery.getManyAndCount();

    const mappedResults: HelpdeskTicketsDTO[] = results.map((ticket) => ({
      ticketId: ticket.ticketId,
      createdAt: ticket.createdAt,
      duoDate: ticket.duoDate,
      status: ticket.status,
      description: ticket.description,
      assignedTo: ticket.assignedTo,
      assignedTo2: {
        fullname: ticket.assignedTo2 ? ticket.assignedTo2.fullname : null,
      },
      group: {
        groupName: ticket.group.groupName,
      },
      user: {
        fullname: ticket.user.fullname,
      },
    }));
  
    return {
      results: mappedResults,
      total: totalResults,
    };
  }
}
