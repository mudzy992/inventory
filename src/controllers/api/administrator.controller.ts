import {
  Body,
  Controller,
  Get,
  Param,
  Patch,
  Post,
  UseGuards,
} from "@nestjs/common";
import { AddAdministratorDto } from "src/dtos/administrator/add.administrator.dto";
import { Administrator } from "src/entities/Administrator";
import { AllowToRoles } from "src/misc/allow.to.roles.descriptor";
import { ApiResponse } from "src/misc/api.response.class";
import { RoleCheckedGuard } from "src/misc/role.checker.guard";
import { AdministratorService } from "src/services/administrator/administrator.service";
import { EditAdministratorDto } from "src/services/administrator/edit.administrator.dto";

@Controller("api/administrator") //kada ovdje dodamo prefiks, onda ne moramo dolje ispod, podrazumijeva se
export class AdministratorController {
  constructor(
    // Uključiti servise administratora
    private administratorService: AdministratorService
  ) {}
  /* Svi administratori */
  @Get()
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles("administrator", "user")
  getAll(): Promise<Administrator[]> {
    return this.administratorService.getAll();
  }
  /* Administrator po ID */
  @Get(":id")
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles("administrator")
  getById(
    @Param("id") administratorId: number
  ): Promise<Administrator | ApiResponse> {
    return new Promise(async (resolve) => {
      const admin = await this.administratorService.getById(administratorId);
      if (admin === undefined) {
        resolve(new ApiResponse("error", -8002));
      }
      resolve(admin);
    });
  }

  @Post()
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles("administrator")
  add(@Body() data: AddAdministratorDto): Promise<Administrator | ApiResponse> {
    return this.administratorService.add(data);
  }

  @Patch(":id")
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles("administrator")
  edit(
    @Param("id") id: number,
    @Body() data: EditAdministratorDto
  ): Promise<Administrator | ApiResponse> {
    return this.administratorService.editById(id, data);
  }
}
