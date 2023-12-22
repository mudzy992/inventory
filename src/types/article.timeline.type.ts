// types.ts

interface User {
  userId: number;
  surname: string;
  forname: string;
  fullname: string;
  localNumber: string;
  telephone: string;
  email: string;
  jobId: number;
  departmentId: number;
  locationId: number;
  registrationDate: Date; // ili Date, zavisno od potrebe
  lastLoginDate: string | null; // ili Date, zavisno od potrebe
  status: "aktivan" | "neaktivan";
  code: number;
  gender: "muško" | "žensko";
  passwordHash?: string;
}

interface Document {
  documentsId: number;
  articleId: number;
  path: string;
  signed_path: string | null;
  documentNumber: number;
  createdDate: Date; // ili Date, zavisno od potrebe
}

interface Article {
  articleId: number;
  serialNumber: string;
  invNumber: string;
  userId: number;
  documentId: number;
  status: string;
  timestamp: Date; // ili Date, zavisno od potrebe
  stockId: number;
  comment: string;
  categoryId: number;
}

interface ArticleTimelineType {
  articleTimelineId: number;
  articleId: number;
  userId: number;
  subbmitedId: number;
  documentId: number;
  serialNumber: string;
  status: string;
  timestamp: Date; // ili Date, zavisno od potrebe
  invNumber: string;
  comment: string;
  article: Article;
  user: User;
  subbmited: User;
  document: Document;
}

export default ArticleTimelineType;
