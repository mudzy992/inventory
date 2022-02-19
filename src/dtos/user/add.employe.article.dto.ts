export class AddEmployeArticleDto {
  articleId: number;
  value: number;
  status: 'zaduženo' | 'razduženo' | 'otpisano';
  comment: string;
}
