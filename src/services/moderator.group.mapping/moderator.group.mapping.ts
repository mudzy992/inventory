import { Injectable } from "@nestjs/common";
import { InjectRepository } from "@nestjs/typeorm";
import { TypeOrmCrudService } from "@nestjsx/crud-typeorm";
import { ModeratorGroupMappingDTO } from "src/dtos/moderator.group.mapping/moderator.group.mapping.dto";
import { ModeratorGroupMapping } from "src/entities/ModeratorGroupMapping";
import { ApiResponse } from "src/misc/api.response.class";
import { Repository } from "typeorm";

@Injectable()
export class ModeratorGroupMappingService extends TypeOrmCrudService<ModeratorGroupMapping> {
  constructor(
    @InjectRepository(ModeratorGroupMapping)
    private readonly moderatorGroup: Repository<ModeratorGroupMapping>,
  ) {
    super(moderatorGroup);
  }

  async getAllGroupModerators(): Promise<ModeratorGroupMappingDTO[] | ApiResponse> {
    const moderators = await this.moderatorGroup.find({
        relations: [
            "user",
            "group",
            "group.location"
        ]
    });

    const response: ModeratorGroupMappingDTO[] = await moderators.map((item) => ({
      group: {
        groupId: item.group.groupId,
        groupName: item.group.groupName,
        location: item.group.location,
      },
      user: {
        userId: item.user.userId,
        fullname: item.user.fullname,
      }
    }))
  
    if (!response) {
      return new ApiResponse('error', -11002, 'Ticket not found.');
    }
    return response;
  }
}
