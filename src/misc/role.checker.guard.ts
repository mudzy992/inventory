import { CanActivate, ExecutionContext, Injectable } from "@nestjs/common";
import { Observable } from "rxjs";
import { Request } from "express";
import { Reflector } from "@nestjs/core";

@Injectable()
export class RoleCheckedGuard implements CanActivate {
  constructor(private reflector: Reflector) {}

  canActivate(
    context: ExecutionContext
  ): boolean | Promise<boolean> | Observable<boolean> {
    const req: Request = context.switchToHttp().getRequest();

    // Pretpostavljamo da rola dolazi iz JWT tokena
    const role = req.token ? req.token.role : null;

    if (!role) {
      // Ako nema rolu u tokenu, zabranjujemo pristup
      return false;
    }

    // Dobavljamo dozvoljene role iz dekoratora
    const allowedToRoles = this.reflector.get<string[]>(
      "allow_to_roles",
      context.getHandler()
    );

    // Proveravamo da li je korisnikova rola među dozvoljenim rolama
    if (!allowedToRoles.includes(role)) {
      return false;
    }

    // Ako je sve u redu, korisnik ima dozvolu za pristup
    return true;
  }
}
