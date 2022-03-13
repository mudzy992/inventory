export class JWTDataDto {
  role: 'administrator' | 'user';
  id: number;
  identity: string;
  exp: number;
  ip: string;
  ua: string;
  // U slučaju da ovdje dodamo još  neki podatak koji će trebati u token
  // automacki će svi prethodni tokeni koji su generisani biti pogrešni
  // logično ako token kreiran sa podacima iznad (unikatni), ne sadrže podatke
  // koje smo naknadno dodali, nisu validni, tj. token nije validan
  // konverzija u plain objekat
  toPlainObject() {
    return {
      role: this.role,
      id: this.id,
      identity: this.identity,
      exp: this.exp,
      ip: this.ip,
      ua: this.ua,
    };
  }
}
