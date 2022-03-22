export class AddEmployeArticleDto {
  articleId: number;
  documentId: number;
  value: number | null;
  comment: string | null;
  serialNumber: string;
  status: 'zaduženo' | 'razduženo' | 'otpisano';
}
