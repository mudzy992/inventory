import { Body, Controller, Delete, Get, Param, Post, UseGuards } from "@nestjs/common";
import { Crud } from "@nestjsx/crud";
import { UpgradeFeatureDto } from "src/dtos/upgradeFeature/upgrade.feature.dto";
import { UpgradeFeature } from "src/entities/UpgradeFeature";
import { AllowToRoles } from "src/misc/allow.to.roles.descriptor";
import { ApiResponse } from "src/misc/api.response.class";
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

  @Get("/get/:serial")
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles("administrator", "moderator", "user")
  getById(
    @Param("serial") serialNumber: string
  ): Promise<UpgradeFeature[] | ApiResponse> {
    return new Promise(async (resolve) => {
      const features = await this.service.getFeaturesByArticleSerialNumber(serialNumber);
      if (features === undefined) {
        resolve(new ApiResponse("error", -9001));
      }
      resolve(features);
    });
  }

  @Post("/add/:sb")
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles("administrator", "moderator")
  async doChangeStatus(
    @Body() data: UpgradeFeatureDto,
    @Param("sb") sb: string
  ) {
    return this.service.newUpgradeFeature(sb, data);
  }

  @Delete("/delete/:id")
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles("administrator", "moderator")
  async deleteUpgradeFeature(@Param("id") id: number) {
    return this.service.deleteUpgradeFeature(id);
  }
}
