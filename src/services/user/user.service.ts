/* eslint-disable prettier/prettier */
import { Injectable } from "@nestjs/common";
import { InjectRepository } from "@nestjs/typeorm";
import { TypeOrmCrudService } from "@nestjsx/crud-typeorm";
import { AddNewEmployeDto } from "src/dtos/user/add.new.employe.dto";
import { User } from "src/entities/User";
import { UserToken } from "src/entities/UserToken";
import { ApiResponse } from "src/misc/api.response.class";
import { Repository } from "typeorm";
import * as crypto from "crypto";
import { EditEmployeeDto } from "src/dtos/user/edit.employee.dto";
import { UserDTO } from "src/dtos/user/user.dto";

@Injectable()
export class UserService extends TypeOrmCrudService<User> {
  constructor(
    @InjectRepository(User)
    private readonly user: Repository<User>,
    @InjectRepository(UserToken)
    private readonly userToken: Repository<UserToken>
  ) {
    super(user);
  }

  async getAll(): Promise<UserDTO[] | ApiResponse> {
    try{
      const users = await this.user.find({
        relations:[
        "department",
        "job",
        "location",
        "organization",
        "location.parentLocation"
      ]
      })
      const userDtos: UserDTO[] = await users.map((user) => ({
        userId: user.userId,
        fullname: user.fullname,
        department: {
          title: user.department.title
        },
        job: {
          title: user.job.title,
        },
        organization: {
          name: user.organization.name,
        },
        location: {
          name: user.location.name,
          parentLocation: {
            name: user.location.parentLocation.name,
          },
        },
        email: user.email,
        localNumber: user.localNumber,
        telephone: user.telephone,
        gender: user.gender,
        status: user.status,
        forname: user.forname,
        surname: user.surname,
      }))
      return userDtos
    } catch (err) {
      return new ApiResponse("error", -6060, 'Greška prilikom dohvaćanja korisnika: ' + err.message )
    }
  }

  async createNewUser(data: AddNewEmployeDto): Promise<User | ApiResponse> {
    const passwordHash = crypto.createHash("sha512");
    passwordHash.update(data.password);
    const passwordHashString = passwordHash.digest("hex").toUpperCase();

    const newUser: User = new User();
    newUser.surname = data.surname;
    newUser.forname = data.forname;
    newUser.email = data.email;
    newUser.localNumber = data.localNumber;
    newUser.telephone = data.telephone;
    newUser.passwordHash = passwordHashString;
    newUser.departmentId = data.departmentId;
    newUser.jobId = data.jobId;
    newUser.locationId = data.locationId;
    newUser.organizationId = data.organizationId;
    newUser.status = data.status;
    newUser.code = data.code;
    newUser.gender = data.gender;

    try {
      const savedUser = await this.user.save(newUser);
      if (!savedUser) {
        throw new Error("");
      }
      return savedUser;
    } catch (e) {
      return new ApiResponse(
        "error",
        -6001,
        "This user account cannot be created." + e.message
      );
    }
  }

  async editUser(userId: number, data: EditEmployeeDto) {
    const passwordHash = crypto.createHash("sha512");
    passwordHash.update(data.password);
    const passwordHashString = passwordHash.digest("hex").toUpperCase();

    const existingUser = await this.user.findOne({ where: { userId: userId } });
    const fullname = data.forname + " " + data.surename;

    existingUser.forname = data.forname;
    existingUser.surname = data.surename;
    existingUser.fullname = fullname;
    existingUser.email = data.email;
    existingUser.passwordHash = passwordHashString;
    existingUser.localNumber = data.localNumber;
    existingUser.telephone = data.telephone;
    existingUser.jobId = data.jobId;
    existingUser.departmentId = data.departmentId;
    existingUser.locationId = data.locationId;
    existingUser.organizationId = data.organizationId;
    existingUser.status = data.status;
    existingUser.code = data.code;
    existingUser.gender = data.gender;

    const saveEditedUser = await this.user.save(existingUser);
    if (!saveEditedUser) {
      return new ApiResponse("error", -6002, "Korisnik ne može biti izmjenjen");
    }
  }

  async getById(id): Promise<UserDTO | ApiResponse> {
    const userData = await this.user.findOne({
      where: { userId: id },
      relations: [
        "department",
        "job",
        "location",
        "organization",
        "helpdeskTickets",
        "helpdeskTickets.group",
        "helpdeskTickets.groupPartent",
        "helpdeskTickets.assignedTo2",
        "helpdeskTickets2",
        "helpdeskTickets2.article",
        "helpdeskTickets2.article.stock",
        "helpdeskTickets2.group",
        "helpdeskTickets2.groupPartent",
        "helpdeskTickets2.assignedTo2",
        "helpdeskTickets2.comments",
        "helpdeskTickets2.comments.user",
        "helpdeskTickets2.comments.comments", 
        "helpdeskTickets2.comments.comments.user",
        "articles",
        "articles.stock",
        "articles.documents",
        "articles.category",
      ],
    });

    const response: UserDTO = {
      userId: userData.userId,
      forname: userData.forname,
      surname: userData.surname,
      fullname: userData.fullname,
      email: userData.email,
      localNumber: userData.localNumber,
      telephone: userData.telephone,
      departmentId: userData.departmentId,
      department: {
        title: userData.department.title,
      },
      jobId: userData.jobId,
      job: {
        title: userData.job.title,
      },
      locationId: userData.locationId,
      location: {
        name: userData.location.name,
      },
      organizationId: userData.organizationId,
      organization: userData.organization,
      status: userData.status,
      code: userData.code,
      gender: userData.gender,
      lastLoginDate: userData.lastLoginDate,
      articles: userData.articles.map((item) => ({
        articleId: item.articleId,
        serialNumber: item.serialNumber,
        invNumber: item.invNumber,
        documents: item.documents.map((doc) => ({
          path: doc.path
        })),
        stock: {
          name: item.stock.name,
        },
        category: {
          name: item.category.name,
        }
      })),
      helpdeskTickets: (userData.helpdeskTickets || []).map((ticket) => ({
        ticketId: ticket.ticketId,
        createdAt: ticket.createdAt,
        duoDate: ticket.duoDate,
        clientDuoDate: ticket.clientDuoDate,
        description: ticket.description,
        resolveDescription: ticket.description,
        resolveDate: ticket.resolveDate,
        status: ticket.status,
        assignedTo2: {
          fullname: ticket.assignedTo2 ? ticket.assignedTo2.fullname : null,
        },
        group: {
          groupName: ticket.group ? ticket.group.groupName : null,
        },
        groupPartent: {
          groupName: ticket.groupPartent ? ticket.groupPartent.groupName : null,
        },

      })),
      helpdeskTickets2: (userData.helpdeskTickets2 || []).map((ticket) => ({
        ticketId: ticket.ticketId,
        createdAt: ticket.createdAt,
        duoDate: ticket.duoDate,
        clientDuoDate: ticket.clientDuoDate,
        description: ticket.description,
        resolveDescription: ticket.resolveDescription,
        resolveDate: ticket.resolveDate,
        status: ticket.status,
        assignedTo2: {
          fullname: ticket.assignedTo2 ? ticket.assignedTo2.fullname : null,
        },
        group: {
          groupName: ticket.group ? ticket.group.groupName : null,
        },
        groupPartent: {
          groupName: ticket.groupPartent ? ticket.groupPartent.groupName : null,
        },
        article: {
          articleId: ticket.article ? ticket.article.articleId : null,
          invNumber: ticket.article ? ticket.article.invNumber : null,
          serialNumber: ticket.article ? ticket.article.serialNumber : null,
          stock: ticket.article && ticket.article.stock ? {
              name: ticket.article.stock.name,
          } : null,
        },
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
      })),

    }
    return response
  }

  async getByUserIdForMainMenu(id:number): Promise<UserDTO | ApiResponse> {
    const userData = await this.user.findOne({
      where: { userId: id },
    });

    const response: UserDTO = {
      userId: userData.userId,
      forname: userData.forname,
      surname: userData.surname,
      fullname: userData.fullname,
      gender: userData.gender
    }
    return response
  }

  async getByEmail(email: string): Promise<User | null> {
    const user = await this.user.findOne({
      where: {
        email: email,
      },
      relations: ["role"],
    });
    if (user) {
      return user;
    }
    return null;
  }

  async addToken(userId: number, token: string, expiresAt: string) {
    const userToken = new UserToken();
    userToken.userId = userId;
    userToken.token = token;
    userToken.expireAt = expiresAt;

    return await this.userToken.save(userToken);
  }

  async getUserToken(token: string): Promise<UserToken | null> {
    try {
      const userToken = await this.userToken.findOne({
        where: {
          token: token,
        },
      });

      return userToken || null;
    } catch (error) {
      console.error("Error fetching user token:", error);
      return null;
    }
  }

  async invalidateToken(token: string): Promise<UserToken | ApiResponse> {
    const userToken = await this.userToken.findOne({
      where: {
        token: token,
      },
    });

    if (!userToken) {
      return new ApiResponse("error", -10001, "No such refresh token!");
    }

    userToken.isValid = 0;

    await this.userToken.save(userToken);

    return await this.getUserToken(token);
  }

  async invalidateUserTokens(
    userId: number
  ): Promise<(UserToken | ApiResponse)[]> {
    const userTokens = await this.userToken.find({
      where: {
        userId: userId,
      },
    });

    const results = [];

    for (const userToken of userTokens) {
      results.push(this.invalidateToken(userToken.token));
    }

    return results;
  }
}
