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
import { sendEmail } from '../email/send.email.service';

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
    const options: Intl.DateTimeFormatOptions = { year: 'numeric', month: 'numeric', day: 'numeric', hour: 'numeric', minute: 'numeric' };
    const newTicket: HelpdeskTickets = new HelpdeskTickets();
    newTicket.userId = data.userId;
    newTicket.articleId = data.articleId;
    newTicket.groupId = data.groupId;
    newTicket.groupPartentId = data.groupPartentId;
    newTicket.description = data.description;
    newTicket.clientDuoDate = data.clientDuoDate;

    try {
        const tiket = await this.helpDeskTickets.save(newTicket);
        const savedTicket = await this.findOne({
          where: { ticketId: tiket.ticketId },
          relations: ["article", "assignedTo2", "group", "groupPartent", "group.moderatorGroupMappings","group.moderatorGroupMappings.user", "user"],
      });
        const clientEmailSubject = `[#${savedTicket.ticketId}] Uspješno kreiran tiket`;
        const clientEmailText = `Vaš tiket (ID: ${savedTicket.ticketId}) je uspješno kreiran. Hvala što ste nas kontaktirali!\n
        \nGrupa: ${savedTicket.group.groupName}
        \nVrsta zahtjeva: ${savedTicket.groupPartent.groupName}
        \nDatum prijave:${savedTicket.createdAt.toLocaleDateString(undefined, options)}
        \nŽeljeni rok:${savedTicket.clientDuoDate.toLocaleDateString(undefined, options)}
        \n\nOpis: ${savedTicket.description}`;
        await sendEmail(savedTicket.user.email, clientEmailSubject, clientEmailText);
        // Slanje emaila administratorima grupe tiketa
        const groupEmailSubject = `[#${savedTicket.ticketId}] Novi tiket otvoren`;
        const groupEmailText = `Novi tiket (ID: ${savedTicket.ticketId}) je otvoren u grupi ${savedTicket.group.groupName}.
        \nPrijavio: ${savedTicket.user.fullname}
        \nGrupa: ${savedTicket.group.groupName}
        \nVrsta zahtjeva: ${savedTicket.groupPartent.groupName}
        \nDatum prijave:${savedTicket.createdAt.toLocaleDateString(undefined, options)}
        \nŽeljeni rok:${savedTicket.clientDuoDate.toLocaleDateString(undefined, options)}
        \n\nOpis: ${savedTicket.description}`;
        const adminEmails = savedTicket.group.moderatorGroupMappings.map(admin => admin.user.email);
        await Promise.all(adminEmails.map(email => sendEmail(email, groupEmailSubject, groupEmailText)));
        const response = new ApiResponse('success', -11000, 'Ticket added successfully.');
        return savedTicket
    } catch (error) {
        return new ApiResponse('error', -11001, 'Failed to add ticket.' + error.message);
    }
  }

  async editTicket(ticketId: number, editTicketDto: EdiTicketDto): Promise<ApiResponse> {
    const existingTicket = await this.helpDeskTickets.findOne({where: {ticketId: ticketId}, relations:["user"]});
  
    if (!existingTicket) {
      return new ApiResponse('error', -11002, 'Ticket not found.');
    }
  
    // Ažurirajte atribute tiketa na osnovu DTO objekta
    existingTicket.groupId = editTicketDto.groupId;
    existingTicket.groupPartentId = editTicketDto.groupPartentId;
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
      if(editTicketDto.status === 'zatvoren'){
        const clientEmailSubject = `[#${ticketId}] Vaš tiket je završen`;
        const clientEmailText = `Vaš tiket (ID: ${ticketId}) je uspješno završen. Hvala što ste nas kontaktirali!\n
        Rješenje zahtjeva: ${editTicketDto.resolveDescription}`;
        await sendEmail(existingTicket.user.email, clientEmailSubject, clientEmailText);
      }
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
        "article.stock",
        "comments",
        "comments.user",
        "comments.comments", 
        "comments.comments.user",
      ]});

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
        invNumber: ticket.article ? ticket.article.invNumber : null,
        serialNumber: ticket.article ? ticket.article.serialNumber : null,
        stock: {
          name: ticket.article ? ticket.article.stock.name : null,
        }
      },
      group: ticket.group,
      groupPartent: ticket.groupPartent,
      comments: (ticket.comments || [])
      .filter((commentItem) => commentItem.parentCommentId === null)
      .map((commentItem) => ({
          commentId: commentItem.commentId,
          text: commentItem.text,
          createdAt: commentItem.createdAt,
          parentCommentId: commentItem.parentCommentId,
          user: {
            fullname: commentItem.user.fullname,
            forname: commentItem.user.forname,
            surname: commentItem.user.surname,
            email: commentItem.user.email,
          },
          comments: (commentItem.comments || []).map((replies) => ({
            commentId: replies.commentId,
            parentCommentId: replies.parentCommentId,
            text: replies.text,
            createdAt: replies.createdAt,
            user: {
              fullname: replies.user.fullname,
              forname: replies.user.forname,
              surname: replies.user.surname,
              email: replies.user.email,
            }
          }))
      }))
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
          qb.orWhere("ticket.ticketId LIKE :query", { query: `%${query}%` });
          qb.orWhere("article.status LIKE :query", { query: `%${query}%` });
          qb.orWhere("group.groupName LIKE :query", { query: `%${query}%` });
        })
      );
    }

    if (assignedTo !== undefined && assignedTo !== null) {
      ticketsQuery.andWhere("ticket.assignedTo = :assignedTo", { assignedTo });
    }
  
    if (status !== undefined) {
      ticketsQuery.andWhere("ticket.status = :status", { status });
    }
  
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
