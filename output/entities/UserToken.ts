import { Column, Entity, PrimaryGeneratedColumn } from "typeorm";

@Entity("user_token", { schema: "inventory" })
export class UserToken {
  @PrimaryGeneratedColumn({
    type: "int",
    name: "user_token_id",
    unsigned: true,
  })
  userTokenId: number;

  @Column("int", { name: "user_id", unsigned: true, default: () => "'0'" })
  userId: number;

  @Column("timestamp", {
    name: "created_at",
    default: () => "CURRENT_TIMESTAMP",
  })
  createdAt: Date;

  @Column("varchar", { name: "token", length: 2550 })
  token: string;

  @Column("datetime", { name: "expire_at" })
  expireAt: Date;

  @Column("tinyint", { name: "is_valid", default: () => "'1'" })
  isValid: number;
}
