export class LoginInfoDto {
  id: number;
  role: string;
  identity: string;
  token: string;
  refreshToken: string;
  refreshTokenExpiresAt: string;

  constructor(
    id: number,
    role: string,
    identity: string,
    jwt: string,
    refreshToken: string,
    refreshTokenExpiresAt: string
  ) {
    this.id = id;
    this.role = role;
    this.identity = identity;
    this.token = jwt;
    this.refreshToken = refreshToken;
    this.refreshTokenExpiresAt = refreshTokenExpiresAt;
  }
}
