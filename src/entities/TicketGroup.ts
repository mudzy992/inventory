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

@Index("location_id", ["locationId"], {})
@Entity("ticket_group", { schema: "inventory_test" })
export class TicketGroup {
  @PrimaryGeneratedColumn({ type: "int", name: "group_id" })
  groupId: number;

  @Column("varchar", { name: "group_name", length: 255 })
  groupName: string;

  @Column("int", { name: "location_id", nullable: true })
  locationId: number | null;

  @OneToMany(() => HelpdeskTickets, (helpdeskTickets) => helpdeskTickets.group)
  helpdeskTickets: HelpdeskTickets[];

  @OneToMany(
    () => ModeratorGroupMapping,
    (moderatorGroupMapping) => moderatorGroupMapping.group
  )
  moderatorGroupMappings: ModeratorGroupMapping[];

  @ManyToOne(() => Location, (location) => location.ticketGroups, {
    onDelete: "NO ACTION",
    onUpdate: "NO ACTION",
  })
  @JoinColumn([{ name: "location_id", referencedColumnName: "locationId" }])
  location: Location;
}
