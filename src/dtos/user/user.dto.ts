import { ArticleTimeline } from "src/entities/ArticleTimeline";
import { ModeratorGroupMapping } from "src/entities/ModeratorGroupMapping";
import { UserRole } from "src/entities/UserRole";
import { UserToken } from "src/entities/UserToken";
import { LocationDTO } from "../location/location.dto";
import { DepartmentDTO } from "../department/department.dto";
import { JobDTO } from "../job/job.dto";
import { ArticleDTO } from "../article/article.dto";
import { HelpdeskTicketsDTO } from "../helpdesk.tickets/helpdesk.tickets.dto";
import { CommentsDTO } from "../comments/comment.dto";
import { OrganizationDTO } from "../organization/organization.dto";

// user.dto.ts
export class UserDTO {
  userId?: number;
  surname?: string;
  forname?: string;
  fullname?: string | null;
  localNumber?: string;
  telephone?: string | null;
  email?: string | null;
  jobId?: number;
  departmentId?: number;
  locationId?: number;
  organizationId?: number;
  phoneIp?:string | null;
  registrationDate?: Date | null;
  lastLoginDate?: string | null;
  status?: "aktivan" | "neaktivan";
  code?: number;
  gender?: "muško" | "žensko" | null;
  roleId?: number;

  role?: Partial<UserRole>;
  articles?: Partial<ArticleDTO>[];
  articleTimelines?: Partial<ArticleTimeline>[];
  articleTimelines2?: Partial<ArticleTimeline>[];
  helpdeskTickets?: Partial<HelpdeskTicketsDTO>[];
  helpdeskTickets2?: Partial<HelpdeskTicketsDTO>[];
  moderatorGroupMappings?: Partial<ModeratorGroupMapping>[];
  job?: Partial<JobDTO>;
  department?: Partial<DepartmentDTO>;
  location?: Partial<LocationDTO>;
  organization?: Partial<OrganizationDTO>;
  userTokens?: Partial<UserToken>[];
  comments?: Partial<CommentsDTO>[];
}
