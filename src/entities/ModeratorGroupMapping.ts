import {
  Column,
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  PrimaryGeneratedColumn,
} from "typeorm";
import { TicketGroup } from "./TicketGroup";
import { User } from "./User";

@Index("group_id", ["groupId"], {})
@Index("user_id", ["userId"], {})
@Entity("moderator_group_mapping")
export class ModeratorGroupMapping {
  @PrimaryGeneratedColumn({ type: "int", name: "mapping_id" })
  mappingId: number;

  @Column("int", { name: "user_id" })
  userId: number;

  @Column("int", { name: "group_id" })
  groupId: number;

  @ManyToOne(
    () => TicketGroup,
    (ticketGroup) => ticketGroup.moderatorGroupMappings,
    { onDelete: "NO ACTION", onUpdate: "NO ACTION" }
  )
  @JoinColumn([{ name: "group_id", referencedColumnName: "groupId" }])
  group: TicketGroup;

  @ManyToOne(() => User, (user) => user.moderatorGroupMappings, {
    onDelete: "NO ACTION",
    onUpdate: "NO ACTION",
  })
  @JoinColumn([{ name: "user_id", referencedColumnName: "userId" }])
  user: User;
}
