import { Body, Controller, Get, Param, Post, UseGuards } from "@nestjs/common";
import { Crud } from "@nestjsx/crud";
import { AddNewCategoryDto } from "src/dtos/category/add.new.category.dto";
import { CategoryDTO } from "src/dtos/category/category.dto";
import { CommentsDTO } from "src/dtos/comments/comment.dto";
import { NewCommentDTO } from "src/dtos/comments/new.comment.dto";
import { Category } from "src/entities/Category";
import { Comments } from "src/entities/Comments";
import { AllowToRoles } from "src/misc/allow.to.roles.descriptor";
import { ApiResponse } from "src/misc/api.response.class";
import { RoleCheckedGuard } from "src/misc/role.checker.guard";
import { CategoryService } from "src/services/category/category.service";
import { CommentsService } from "src/services/comment/comment.service";

@Controller("api/comment")
@Crud({
  model: {
    type: Category,
  },
  params: {
    id: {
      field: "commentId",
      type: "number",
      primary: true,
    },
  },
  query: {
    join: {
      commentHelpdeskTickets: {
        eager: true,
      },
      parentComment: {
        eager: true,
      },
      comments: {
        eager: true,
      }
    },
  },
})
export class CommentsController {
  constructor(public service: CommentsService) {}

  @Get()
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles('administrator', 'moderator', 'user')
  async getAllComments(): Promise<CommentsDTO[] | ApiResponse>{
    return this.service.getAllComments()
  }

  @Get(":id")
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles('administrator', 'moderator', 'user')
  async getCommentById(
    @Param("id") id: number
  ): Promise<Comments | ApiResponse>{
    return this.service.getCommentById(id)
  }

  @Post()
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles("administrator", "moderator", "user")
  async createNewComment(
    @Body() data: NewCommentDTO
  ): Promise<Comments | ApiResponse> {
    return await this.service.createComment(data);
  }

  @Post("reply/:id")
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles("administrator", "moderator", "user")
  async createReply(
    @Param("id") id: number,
    @Body() data: NewCommentDTO
  ): Promise<Comments | ApiResponse> {
    return await this.service.createReply(id, data);
  }
}
