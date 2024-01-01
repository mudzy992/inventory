import { TicketGroup } from "src/entities/TicketGroup";
import { UserDTO } from "../user/user.dto";
import { ArticleDTO } from "../article/article.dto";

export class HelpdeskTicketsDTO {
  ticketId?: number;
  userId?: number;
  articleId?: number | null;
  groupId?: number;
  groupPartentId?: number | null;
  description?: string;
  resolveDescription?: string | null;
  createdAt?: Date | null;
  duoDate?: Date | null;
  status?: "otvoren" | "izvršenje" | "zatvoren";
  assignedTo?: number | null;
  clientDuoDate?: Date | null;
  resolveDate?: Date | null;
  priority?:
    | "Problem veće hitnosti ili VIP korisnik"
    | "Problem u radu servisa (za sve korisnike u firmi)"
    | "Poteškoće u radu grupe korisnika"
    | "Povremene poteškoće u radu grupe korisnika"
    | "Poteškoće u radu korisnika"
    | "Potrebna pomoć korisniku"
    | "Zahtjevi za izmjenu/doradu manje složenosti"
    | "Zahtjevi za izmjenu/doradu veće složenosti"
    | null;
  resolveTimespand?: string | null;
  resolveResolution?:
    | "Nemoguće riješiti ili je u koliziji sa standardom ili politikom"
    | "Riješen - nije potrebna analiza uzroka"
    | "Uzrok problema nije otklonjen - privremeno rješenje"
    | "Zahtjev je povučen od strane korisnika"
    | null;

  article?: Partial<ArticleDTO>;
  assignedTo2?: Partial<UserDTO>;
  group?: Partial<TicketGroup>;
  groupPartent?: Partial<TicketGroup>;
  user?: Partial<UserDTO>;
}
