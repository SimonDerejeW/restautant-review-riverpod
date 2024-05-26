import { PartialType } from '@nestjs/mapped-types';
import { CreateAdminFuncDto } from './create-admin_func.dto';

export class UpdateAdminFuncDto extends PartialType(CreateAdminFuncDto) {}
