export class EdiTicketDto {
    groupId: number;
    groupPartentId: number;
    resolveDescription:string;
    duoDate: Date;
    resolveDate: Date;
    resolveTimespand: string;
    assignedTo: number;
    status: "otvoren" | "izvršenje" | "zatvoren";
    priority: "Problem veće hitnosti ili VIP korisnik"
    | "Problem u radu servisa (za sve korisnike u firmi)"
    | "Poteškoće u radu grupe korisnika"
    | "Povremene poteškoće u radu grupe korisnika"
    | "Poteškoće u radu korisnika"
    | "Potrebna pomoć korisniku"
    | "Zahtjevi za izmjenu/doradu manje složenosti"
    | "Zahtjevi za izmjenu/doradu veće složenosti";
    resolveResolution:  "Nemoguće riješiti ili je u koliziji sa standardom ili politikom"
    | "Riješen - nije potrebna analiza uzroka"
    | "Uzrok problema nije otklonjen - privremeno rješenje"
    | "Zahtjev je povučen od strane korisnika";
}
