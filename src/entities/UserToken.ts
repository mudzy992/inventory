import {
  Column,
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  PrimaryGeneratedColumn,
} from "typeorm";
import { User } from "./User";

@Index("user_id", ["userId"], {})
@Entity("user_token")
export class UserToken {
  @PrimaryGeneratedColumn({ type: "int", name: "user_token_id" })
  userTokenId: number;

  @Column("int", { name: "user_id", nullable: true })
  userId: number | null;

  @Column("timestamp", {
    name: "created_at",
    nullable: true,
    default: () => "CURRENT_TIMESTAMP",
  })
  createdAt: Date | null;

  @Column("varchar", { name: "token", length: 255 })
  token: string;

  @Column("bigint", { name: "expire_at", nullable: true })
  expireAt: string | null;

  @Column("tinyint", { name: "is_valid", nullable: true, width: 1 })
  isValid: number | null;

  @ManyToOne(() => User, (user) => user.userTokens, {
    onDelete: "NO ACTION",
    onUpdate: "NO ACTION",
  })
  @JoinColumn([{ name: "user_id", referencedColumnName: "userId" }])
  user: User;
}
