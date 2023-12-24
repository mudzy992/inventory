import { Injectable } from "@nestjs/common";
import { InjectRepository } from "@nestjs/typeorm";
import { TypeOrmCrudService } from "@nestjsx/crud-typeorm";
import { AddNewTicketDto } from "src/dtos/helpdesk.tickets/add.ticket.dto";
import { EdiTicketDto } from "src/dtos/helpdesk.tickets/edit.ticket.dto";
import { HelpdeskTickets } from "src/entities/HelpdeskTickets";
import { User } from "src/entities/User";
import { ApiResponse } from "src/misc/api.response.class";
import { Repository } from "typeorm";

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
    console.log('Received request with data:', data);
    const newTicket: HelpdeskTickets = new HelpdeskTickets();
    newTicket.userId = data.userId;
    newTicket.articleId = data.articleId;
    newTicket.groupId = data.groupId;
    newTicket.title = data.title;
    newTicket.description = data.description;
    newTicket.dueDate = data.duoDate;
    newTicket.assignedTo = data.assignedTo;

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
    existingTicket.userId = editTicketDto.userId;
    existingTicket.articleId = editTicketDto.articleId;
    existingTicket.groupId = editTicketDto.groupId;
    existingTicket.title = editTicketDto.title;
    existingTicket.description = editTicketDto.description;
    existingTicket.resolveDescription = editTicketDto.resolveDescription;
    existingTicket.dueDate = editTicketDto.duoDate;
    existingTicket.status = editTicketDto.status;
    existingTicket.assignedTo = editTicketDto.assignedTo;
  
    try {
      await this.helpDeskTickets.save(existingTicket);
      return new ApiResponse('success', -11003, 'Ticket edited successfully.');
    } catch (error) {
      return new ApiResponse('error', -11004, 'Failed to edit ticket.');
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

  async getTicketById(ticketId: number): Promise<HelpdeskTickets | ApiResponse> {
    const ticket = await this.helpDeskTickets.findOne({where: {ticketId: ticketId}});
  
    if (!ticket) {
      return new ApiResponse('error', -11002, 'Ticket not found.');
    }
  
    return ticket;
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
}
