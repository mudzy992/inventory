import { Article } from "src/entities/Article";
import { Stock } from "src/entities/Stock";
import { TicketGroup } from "src/entities/TicketGroup";
import { Feature } from "typeorm";

export class CategoryDTO {
  categoryId?: number;
  name?: string;
  imagePath?: string | null;
  parentCategoryId?: number | null;
  groupId?: number;

  articles?: Partial<Article>[];
  group?: Partial<TicketGroup>;
  parentCategory?: Partial<CategoryDTO>;
  categories?: Partial<CategoryDTO>[];
  features?: Partial<Feature>[];
  stocks?: Partial<Stock>[];
}
