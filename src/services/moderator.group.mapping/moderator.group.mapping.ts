import { Injectable } from "@nestjs/common";
import { InjectRepository } from "@nestjs/typeorm";
import { TypeOrmCrudService } from "@nestjsx/crud-typeorm";
import { ModeratorGroupMappingDTO } from "src/dtos/moderator.group.mapping/moderator.group.mapping.dto";
import { ModeratorGroupMapping } from "src/entities/ModeratorGroupMapping";
import { TicketGroup } from "src/entities/TicketGroup";
import { ApiResponse } from "src/misc/api.response.class";
import { Repository } from "typeorm";

@Injectable()
export class ModeratorGroupMappingService extends TypeOrmCrudService<ModeratorGroupMapping> {
  constructor(
    @InjectRepository(ModeratorGroupMapping)
    private readonly moderatorGroup: Repository<ModeratorGroupMapping>,
    @InjectRepository(TicketGroup)
    private readonly ticketGroup: Repository<TicketGroup>,
  ) {
    super(moderatorGroup);
  }

  async getAllGroupModerators(): Promise<
    ModeratorGroupMappingDTO[] | ApiResponse
  > {
    const moderators = await this.moderatorGroup.find({
      relations: ["user", "group", "group.location"],
    });

    const response: ModeratorGroupMappingDTO[] = await Promise.all(
      moderators.map(async (item) => {
        const subGroups = await this.ticketGroup.find({
          where: { parentGroupId: item.groupId },
        });
        return {
          groupId: item.groupId,
          group: {
            groupId: item.group.groupId,
            parentGroupId: item.group.parentGroupId,
            groupName: item.group.groupName,
            location: item.group.location,
            ticketGroups: subGroups
              ? subGroups.map((sub) => ({
                  groupId: sub.groupId,
                  parentGroupId: sub.parentGroupId,
                  groupName: sub.groupName,
                }))
              : [],
          },
          user: {
            userId: item.user.userId,
            fullname: item.user.fullname,
          },
        };
      }),
    );

    if (!moderators) {
      return new ApiResponse("error", -11002, "Ticket not found.");
    }
    return response;
  }
}
