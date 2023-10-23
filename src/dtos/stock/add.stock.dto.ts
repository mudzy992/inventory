export class AddStockDto {
    name: string;
    excerpt: string | null;
    description: string | null;
    contract: string | null;
    categoryId: number;
    sapNumber: string;
    valueOnContract: number;
    valueAvailable: number;
  }
  