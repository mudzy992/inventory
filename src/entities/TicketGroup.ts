import {
  Column,
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  OneToMany,
  PrimaryGeneratedColumn,
} from "typeorm";
import { HelpdeskTickets } from "./HelpdeskTickets";
import { ModeratorGroupMapping } from "./ModeratorGroupMapping";
import { Location } from "./Location";
import { Category } from "./Category";

@Index("location_id", ["locationId"], {})
@Index("fk2_parent_group_id_group_id", ["parentGroupId"], {})
@Entity("ticket_group", { schema: "inventory_v2" })
export class TicketGroup {
  @PrimaryGeneratedColumn({ type: "int", name: "group_id" })
  groupId: number;

  @Column("varchar", { name: "group_name", length: 255 })
  groupName: string;

  @Column("int", { name: "location_id", nullable: true })
  locationId: number | null;

  @Column("int", { name: "parent_group_id", nullable: true })
  parentGroupId: number | null;

  @OneToMany(() => Category, (category) => category.group)
  categories: Category[];

  @OneToMany(() => HelpdeskTickets, (helpdeskTickets) => helpdeskTickets.group)
  helpdeskTickets: HelpdeskTickets[];

  @OneToMany(
    () => HelpdeskTickets,
    (helpdeskTickets) => helpdeskTickets.groupPartent
  )
  helpdeskTickets2: HelpdeskTickets[];

  @OneToMany(
    () => ModeratorGroupMapping,
    (moderatorGroupMapping) => moderatorGroupMapping.group
  )
  moderatorGroupMappings: ModeratorGroupMapping[];

  @ManyToOne(() => TicketGroup, (ticketGroup) => ticketGroup.ticketGroups, {
    onDelete: "NO ACTION",
    onUpdate: "NO ACTION",
  })
  @JoinColumn([{ name: "parent_group_id", referencedColumnName: "groupId" }])
  parentGroup: TicketGroup;

  @OneToMany(() => TicketGroup, (ticketGroup) => ticketGroup.parentGroup)
  ticketGroups: TicketGroup[];

  @ManyToOne(() => Location, (location) => location.ticketGroups, {
    onDelete: "NO ACTION",
    onUpdate: "NO ACTION",
  })
  @JoinColumn([{ name: "location_id", referencedColumnName: "locationId" }])
  location: Location;
}
