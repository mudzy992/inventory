export class LoginInfoDto {
  id: number;
  role: string;
  identity: string;
  phoneIp: string;
  token: string;
  refreshToken: string;
  refreshTokenExpiresAt: string;

  constructor(
    id: number,
    role: string,
    identity: string,
    jwt: string,
    phoneIp: string,
    refreshToken: string,
    refreshTokenExpiresAt: string
  ) {
    this.id = id;
    this.role = role;
    this.identity = identity;
    this.phoneIp = phoneIp;
    this.token = jwt;
    this.refreshToken = refreshToken;
    this.refreshTokenExpiresAt = refreshTokenExpiresAt;
  }
}
