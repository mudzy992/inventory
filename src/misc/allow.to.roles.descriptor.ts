import { SetMetadata } from "@nestjs/common";

export const AllowToRoles = (...roles: ("administrator" | "user" | "moderator")[]) => {
  return SetMetadata("allow_to_roles", roles);
};
