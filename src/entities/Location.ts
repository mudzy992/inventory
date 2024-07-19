import {
  Column,
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  OneToMany,
  PrimaryGeneratedColumn,
} from "typeorm";
import { DepartmentJob } from "./DepartmentJob";
import { User } from "./User";
import { TicketGroup } from "./TicketGroup";

@Index("code", ["code"], { unique: true })
@Index("parent_location_id", ["parentLocationId"], {})
@Entity("location", { schema: "inventory_v2" })
export class Location {
  @PrimaryGeneratedColumn({ type: "int", name: "location_id" })
  locationId: number;

  @Column("varchar", { name: "name", length: 255 })
  name: string;

  @Column("varchar", { name: "code", nullable: true, unique: true, length: 50 })
  code: string | null;

  @Column("int", { name: "parent_location_id", nullable: true })
  parentLocationId: number | null;

  @OneToMany(() => DepartmentJob, (departmentJob) => departmentJob.location)
  departmentJobs: DepartmentJob[];

  @ManyToOne(() => Location, (location) => location.locations, {
    onDelete: "NO ACTION",
    onUpdate: "NO ACTION",
  })
  @JoinColumn([
    { name: "parent_location_id", referencedColumnName: "locationId" },
  ])
  parentLocation: Location;

  @OneToMany(() => Location, (location) => location.parentLocation)
  locations: Location[];

  @OneToMany(() => User, (user) => user.location)
  users: User[];

  @OneToMany(() => TicketGroup, (ticketGroup) => ticketGroup.location)
  ticketGroups: TicketGroup[];
}
