export class EdiTicketDto {
    userId: number;
    articleId: number;
    groupId: number;
    title: string;
    description: string;
    resolveDescription:string;
    duoDate: string;
    assignedTo: number;
    status: "otvoren" | "izvršenje" | "zatvoren";
}
