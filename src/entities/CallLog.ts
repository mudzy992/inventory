// src/entities/CallLog.entity.ts
import { Entity, PrimaryGeneratedColumn, Column, CreateDateColumn, Index } from 'typeorm';

@Index("id", ["id"], {})
@Entity("call_log")
export class CallLog {
  @PrimaryGeneratedColumn({type: "int", name: "id"})
  id: number;

  @Column("varchar", {name: "number"})
  number: string;

  @Column("varchar", {name: "status"})
  status: string;

  @Column("date", {
    name: "created_at",
    default: () => "CURRENT_TIMESTAMP",
  })
  createdAt: Date;
}
