import { Documents } from "src/entities/Documents";
import { User } from "src/entities/User";
import { ArticleDTO } from "../article/article.dto";

export class ArticleTimelineDTO {
  articleTimelineId?: number;
  articleId?: number;
  userId?: number | null;
  subbmitedId?: number | null;
  documentId?: number | null;
  serialNumber?: string | null;
  status?: "zaduženo" | "razduženo" | "otpisano" | null;
  timestamp?: Date | null;
  invNumber?: string | null;
  comment?: string | null;

  // Sva polja vezana za relacije ostavljamo kao opciona
  article?: Partial<ArticleDTO>;
  user?: Partial<User>;
  document?: Partial<Documents>;
  subbmited?: Partial<User>;
}
