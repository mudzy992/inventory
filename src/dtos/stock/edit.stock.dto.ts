export class UpdateStockDto {
  name?: string; // Novo ime artikla u skladištu
  excerpt?: string | null; // Novi sažetak
  description?: string | null; // Nova opis
  contract?: string | null; // Novi ugovor
  categoryId?: number; // Nova kategorija (ako se mijenja)
  sapNumber?: string; // Novi SAP broj
  valueOnContract?: number; // Nova vrijednost na ugovoru
  valueAvailable?: number; // Nova dostupna vrijednost
}
