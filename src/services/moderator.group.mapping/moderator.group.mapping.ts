import { Injectable } from "@nestjs/common";
import { InjectRepository } from "@nestjs/typeorm";
import { TypeOrmCrudService } from "@nestjsx/crud-typeorm";
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

  async getAllGroupModerators(): Promise<ModeratorGroupMapping[] | ApiResponse> {
    const moderators = await this.moderatorGroup.find({
        relations: [
            "user",
            "group",
            "group.location"
        ]
    });
  
    if (!moderators) {
      return new ApiResponse('error', -11002, 'Ticket not found.');
    }
    return moderators;
  }
}
