import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';
import { User } from 'src/schemas/user.schema';
import { Model } from 'mongoose';
import { NotFoundError } from 'rxjs';
import * as bcrypt from 'bcrypt';


@Injectable()
export class UsersService {
  constructor(
    @InjectModel(User.name) private userModel: Model<User>,
  ) {}

  create(createUserDto: CreateUserDto) {
    return 'This action adds a new user';
  }

  findAll() {
    return `This action returns all users`;
  }

  findOne(id: number) {
    return `This action returns a #${id} user`;
  }

  async updateUsername(id: string, updateUserDto: UpdateUserDto) {
    const {new_username} = updateUserDto
    const user = await this.userModel.findOne({_id: id})
    if (!user){
      throw new BadRequestException('User not found')
    }else(
      user.username = new_username
    )
    await user.save()

    return `your new username is ${new_username} `
  }

  async updatePassword(id:string, updateUserDto: UpdateUserDto){
    const {old_password, new_password} = updateUserDto
    const user = await this.userModel.findOne({_id:id})
    if (!user){
      throw new BadRequestException('User not found')
    }

    const isMatch = await bcrypt.compare(old_password, user.password);

    if (!isMatch) {
      throw new BadRequestException('Invalid credentials');
    }else{
      const new_hashedPassword = await bcrypt.hash(new_password, 10);
      user.password = new_hashedPassword
    }
    await user.save()

    return `old password ${old_password}, new password ${new_password}` 
    // return 'your new password is saved'
  }

  async remove(id: string): Promise<string> {
    await this.userModel.deleteOne({_id: id}).exec();
    return `Account Deleted Successfully`;
  }
}
