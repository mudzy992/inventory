export class AddEmployeArticleDto {
  articleId: number;
  value: number | null;
  comment: string | null;
  serialNumber: string;
  status: 'zaduženo' | 'razduženo' | 'otpisano';
}
