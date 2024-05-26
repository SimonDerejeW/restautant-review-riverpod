import {
  CanActivate,
  ExecutionContext,
  Injectable,
  UnauthorizedException,
} from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { UserRole } from '../enums/roles.enum';
import { JwtService } from '@nestjs/jwt'; // Assuming you are using the JwtService

@Injectable()
export class RolesGuard implements CanActivate {
  constructor(
    private reflector: Reflector,
    private jwtService: JwtService,
  ) {}

  async canActivate(context: ExecutionContext): Promise<boolean> {
    const requiredRoles = this.reflector.get<UserRole[]>(
      'roles',
      context.getHandler(),
    );

    if (!requiredRoles) {
      return true; // No roles are required, access is granted
    }

    const request = context.switchToHttp().getRequest();
    console.log(request);
    const token = this.extractToken(request);

    if (!token) {
      throw new UnauthorizedException('No token provided');
    }

    let decodedUser;
    try {
      // Validate and decode the token
      decodedUser = this.jwtService.verify(token, { secret: 'MYSECRETKEY' });
    } catch (error) {
      throw new UnauthorizedException('Invalid token');
    }
    console.log(decodedUser);
    // Check if the user is authenticated
    if (!decodedUser || !decodedUser.roles) {
      throw new UnauthorizedException('User not authenticated');
    }

    // Attach the decoded user to the request for further use
    request.user = decodedUser;

    // Check if the user has at least one of the required roles
    return requiredRoles.some((role) => decodedUser.roles.includes(role));
  }

  private extractToken(request): string | null {
    const authorizationHeader = request.headers.authorization;

    if (authorizationHeader && authorizationHeader.split(' ')[0] === 'Bearer') {
      return authorizationHeader.split(' ')[1];
    }

    return null;
  }
}
