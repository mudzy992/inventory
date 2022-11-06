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

@Index("FK_location_location", ["parentLocationId"], {})
@Entity("location", { schema: "inventory" })
export class Location {
  @PrimaryGeneratedColumn({ type: "int", name: "location_id", unsigned: true })
  locationId: number;

  @Column("varchar", { name: "name", length: 50 })
  name: string;

  @Column("varchar", { name: "code", length: 50 })
  code: string;

  @Column("int", { name: "parent_location_id", nullable: true, unsigned: true })
  parentLocationId: number | null;

  @OneToMany(() => DepartmentJob, (departmentJob) => departmentJob.location)
  departmentJobs: DepartmentJob[];

  @ManyToOne(() => Location, (location) => location.locations, {
    onDelete: "RESTRICT",
    onUpdate: "CASCADE",
  })
  @JoinColumn([
    { name: "parent_location_id", referencedColumnName: "locationId" },
  ])
  parentLocation: Location;

  @OneToMany(() => Location, (location) => location.parentLocation)
  locations: Location[];

  @OneToMany(() => User, (user) => user.location)
  users: User[];
}
