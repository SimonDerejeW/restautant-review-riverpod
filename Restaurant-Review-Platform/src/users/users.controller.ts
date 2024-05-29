import {
  Body,
  Controller,
  Delete,
  Get,
  NotFoundException,
  Param,
  Post,
  Put,
  Patch,
  Query,
  Req,
  UseGuards,
} from '@nestjs/common';
import { UsersService } from './users.service';
import { User } from 'src/schemas/user.schema';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';
import { Roles } from 'src/auth/decorators/roles.decorator';
import { UserRole } from 'src/auth/enums/roles.enum';
import { RolesGuard } from 'src/auth/guards/roles.guard';
import { Auth } from 'src/auth/entities/auth.entity';
import { AuthGuard } from 'src/auth/guards/auth.guard';
import { query } from 'express';

@Controller('users')
export class UsersController {
  constructor(private readonly usersService: UsersService) {}

  @Post()
  @UseGuards(AuthGuard, RolesGuard)
  @Roles(UserRole.OWNER)
  create(@Body() createUserDto: CreateUserDto) {
    return this.usersService.create(createUserDto);
  }

  @Get()
  @UseGuards(AuthGuard, RolesGuard)
  @Roles(UserRole.ADMIN)
  findAll(@Query('roles') roles: string) {
    return this.usersService.findAll(roles);
  }

  @Get(':id')
  @UseGuards(AuthGuard, RolesGuard)
  async getRestaurant(@Param('id') id: string): Promise<User> {
    try {
      return this.usersService.findOne(id);
    } catch (e) {
      throw new NotFoundException(e.message);
    }
  }

  //change user name
  @Patch('/changeUserName/:id')
  @UseGuards(AuthGuard, RolesGuard)
  updateUsername(
    @Param('id') id: string,
    @Body() updateUserDto: UpdateUserDto,
  ) {
    return this.usersService.updateUsername(id, updateUserDto);
  }

  //change user password
  @Patch('/changePassword/:id')
  @UseGuards(AuthGuard, RolesGuard)
  updatePassword(
    @Param('id') id: string,
    @Body() updateUserDto: UpdateUserDto,
  ) {
    return this.usersService.updatePassword(id, updateUserDto);
  }

  //delete account
  @Delete(':id')
  @UseGuards(AuthGuard, RolesGuard)
  remove(@Param('id') id: string) {
    return this.usersService.remove(id);
  }
}
