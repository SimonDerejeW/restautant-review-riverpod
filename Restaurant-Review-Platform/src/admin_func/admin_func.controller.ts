import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { AdminFuncService } from './admin_func.service';
import { CreateAdminFuncDto } from './dto/create-admin_func.dto';
import { UpdateAdminFuncDto } from './dto/update-admin_func.dto';

@Controller('admin-func')
export class AdminFuncController {
  constructor(private readonly adminFuncService: AdminFuncService) {}

  // @Post()
  // create(@Body() createAdminFuncDto: CreateAdminFuncDto) {
  //   return this.adminFuncService.create(createAdminFuncDto);
  // }

  @Get()
  findAll() {
    return 'here';
  }

  // @Get(':id')
  // findOne(@Param('id') id: string) {
  //   return this.adminFuncService.findOne(+id);
  // }

  @Patch('/ban/:username')
  ban(@Param('username') username: string) {
    return this.adminFuncService.ban(username);
  }

  @Patch('/unban/:username')
  unban(@Param('username') username: string) {
    return this.adminFuncService.unban(username);
  }

  // @Delete(':id')
  // remove(@Param('id') id: string) {
  //   return this.adminFuncService.remove(+id);
  // }
}
