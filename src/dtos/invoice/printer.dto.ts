export class PrinterDTO {
  printerId: number;
  userCode: string | null;
  connection: string | null;
  printerType: string | null;
  serialNumber: string | null;
  activity: string | null;
  rentalType: string;
  ownership: string | null;
  status: 'activated' | 'deactivated' | null;
  counters: {
    oid27: { 
      current: { value: number, printerOidId: number | null } | null;
      previous: { value: number, printerOidId: number | null } | null;
    };
    oid28: { 
      current: { value: number, printerOidId: number | null } | null;
      previous: { value: number, printerOidId: number | null } | null;
    };
    oid29: { 
      current: { value: number, printerOidId: number | null } | null;
      previous: { value: number, printerOidId: number | null } | null;
    };
  };
}
