import { Body, Controller, Get, Param, Patch, Post, UseGuards } from "@nestjs/common";
import { Crud } from "@nestjsx/crud";
import { AddNewEmployeDto } from "src/dtos/user/add.new.employe.dto";
import { EditEmployeeDto } from "src/dtos/user/edit.employee.dto";
import { User } from "src/entities/User";
import { AllowToRoles } from "src/misc/allow.to.roles.descriptor";
import { ApiResponse } from "src/misc/api.response.class";
import { RoleCheckedGuard } from "src/misc/role.checker.guard";
import { UserService } from "src/services/user/user.service";

@Controller("api/user/")
@Crud({
  model: {
    type: User,
  },
  params: {
    id: {
      field: "userId",
      type: "number",
      primary: true,
    },
  },
  query: {
    join: {
      articles: {
        eager: true,
      },
      articleTimelines: {
        eager: true,
      },
      job: {
        eager: true,
      },
      department: {
        eager: true,
      },
      location: {
        eager: true,
      },
    },
    exclude: ["passwordHash"],
    sort: [{ field: "fullname", order: "ASC" }],
  },
})
export class UserController {
  constructor(public service: UserService) {}

  @Get()
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles("user", "administrator", "moderator")
  async getAll(): Promise<User[] | ApiResponse> {
    return await this.service.getAll()
  }

  @Get(":id")
  async getStockById(@Param("id") userId: number): Promise<User | ApiResponse> {
    return this.service.getById(userId);
  }

  @Post("/add/")
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles("user", "administrator", "moderator")
  async createNewUser(
    @Body() data: AddNewEmployeDto
  ): Promise<User | ApiResponse> {
    const email = await this.service.getByEmail(data.email);
    if (email) {
      return new ApiResponse(
        "error",
        -2001,
        "Radnik već postoji u bazi podataka"
      );
    }
    return await this.service.createNewUser(data);
  }

  @Patch("/edit/:id")
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles("user", "administrator", "moderator")
  async editUser(@Param("id") id: number, @Body() data: EditEmployeeDto) {
    return await this.service.editUser(id, data);
  }
} /* Kraj koda */
