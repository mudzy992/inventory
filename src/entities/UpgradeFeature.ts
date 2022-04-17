import {
  Column,
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  PrimaryGeneratedColumn,
} from "typeorm";
import { UserArticle } from "./UserArticle";

@Index(
  "fk_upgrade_feature_serial_number_user_article_serial_number",
  ["serialNumber"],
  {}
)
@Entity("upgrade_feature", { schema: "inventory" })
export class UpgradeFeature {
  @PrimaryGeneratedColumn({
    type: "int",
    name: "upgrade_feature_id",
    unsigned: true,
  })
  upgradeFeatureId: number;

  @Column("varchar", { name: "name", length: 50 })
  name: string;

  @Column("varchar", { name: "value", length: 50 })
  value: string;

  @Column("timestamp", {
    name: "timestamp",
    default: () => "CURRENT_TIMESTAMP",
  })
  timestamp: Date;

  @Column("varchar", { name: "comment", length: 255 })
  comment: string;

  @Column("varchar", { name: "serial_number", length: 50 })
  serialNumber: string;

  @ManyToOne(() => UserArticle, (userArticle) => userArticle.upgradeFeatures, {
    onDelete: "RESTRICT",
    onUpdate: "CASCADE",
  })
  @JoinColumn([{ name: "serial_number", referencedColumnName: "serialNumber" }])
  serialNumber2: UserArticle;
}
