import { Category } from "src/entities/Category";
import { Documents } from "src/entities/Documents";
import { HelpdeskTickets } from "src/entities/HelpdeskTickets";
import { UpgradeFeature } from "src/entities/UpgradeFeature";
import { StockDTO } from "../stock/stocks.dto";
import { UserDTO } from "../user/user.dto";
import { ArticleTimelineDTO } from "../article.timeline/article.timeline.dto";

// article.dto.ts
export class ArticleDTO {
    articleId?: number;
    serialNumber?: string;
    invNumber?: string;
    userId?: number | null;
    documentId?: number | null;
    status?: "zaduženo" | "razduženo" | "otpisano";
    timestamp?: Date | null;
    stockId?: number;
    comment?: string | null;
    categoryId?: number | null;
    user?: Partial<UserDTO>;
    stock?: Partial<StockDTO>;
    category?: Partial<Category>;
    articleTimelines?: Partial<ArticleTimelineDTO>[];
    documents?: Partial<Documents>[];
    helpdeskTickets?: Partial<HelpdeskTickets>[];
    upgradeFeatures?: Partial<UpgradeFeature>[];
  }
  