import { Documents } from "src/entities/Documents";
import { UpgradeFeature } from "src/entities/UpgradeFeature";
import { StockDTO } from "../stock/stocks.dto";
import { UserDTO } from "../user/user.dto";
import { ArticleTimelineDTO } from "../article.timeline/article.timeline.dto";
import { HelpdeskTicketsDTO } from "../helpdesk.tickets/helpdesk.tickets.dto";
import { CategoryDTO } from "../category/category.dto";
import { ArticleFeatures } from "src/entities/ArticleFeatures";
import { ArticleFeaturesDto } from "../article.features/article.features.dto";

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
    category?: Partial<CategoryDTO>;
    articleTimelines?: Partial<ArticleTimelineDTO>[];
    documents?: Partial<Documents>[];
    helpdeskTickets?: Partial<HelpdeskTicketsDTO>[];
    upgradeFeatures?: Partial<UpgradeFeature>[];
    articleFeatures?: Partial<ArticleFeaturesDto>[];
  }
  