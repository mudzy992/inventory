export class JWTDataDto {
  role: string;
  id: number;
  identity: string;
  exp: number;
  ip: string;
  ua: string;
  phoneIp: string;
  toPlainObject() {
    return {
      role: this.role,
      id: this.id,
      identity: this.identity,
      exp: this.exp,
      ip: this.ip,
      ua: this.ua,
      phoneIp: this.phoneIp,
    };
  }
}
