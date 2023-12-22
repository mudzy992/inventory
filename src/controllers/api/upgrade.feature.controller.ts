import { Body, Controller, Delete, Get, Param, Post, UseGuards } from "@nestjs/common";
import { Crud } from "@nestjsx/crud";
import { UpgradeFeatureDto } from "src/dtos/upgradeFeature/upgrade.feature.dto";
import { UpgradeFeature } from "src/entities/UpgradeFeature";
import { AllowToRoles } from "src/misc/allow.to.roles.descriptor";
import { RoleCheckedGuard } from "src/misc/role.checker.guard";
import { UpgradeFeatureService } from "src/services/upgradeFeature/upgrade.features.service";

@Controller("api/upgradeFeature")
@Crud({
  model: {
    type: UpgradeFeature,
  },
  params: {
    id: {
      field: "upgradeFeatureId",
      type: "number",
      primary: true,
    },
  },
  query: {
    join: {
      article: {
        eager: true,
      },
    },
  },
})
export class UpgradeFeatureController {
  constructor(public service: UpgradeFeatureService) {}
  @Get()
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles("user", "administrator", "moderator")
  async getAll(): Promise<UpgradeFeature[]>{
    return await this.service.getAll()
  }

  @Post("/add/:sb")
  async doChangeStatus(
    @Body() data: UpgradeFeatureDto,
    @Param("sb") sb: string
  ) {
    return this.service.newUpgradeFeature(sb, data);
  }

  @Delete("/delete/:id")
  async deleteUpgradeFeature(@Param("id") id: number) {
    return this.service.deleteUpgradeFeature(id);
  }
}
