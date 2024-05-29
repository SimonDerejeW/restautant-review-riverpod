import {
  Injectable,
  HttpException,
  HttpStatus,
  BadRequestException,
} from '@nestjs/common';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { User, UserDocument } from 'src/schemas/user.schema';
import * as bcrypt from 'bcrypt';

@Injectable()
export class UsersService {
  constructor(
    @InjectModel(User.name)
    private userModel: Model<UserDocument>,
  ) {}

  create(createUserDto: CreateUserDto) {
    return 'This action adds a new user';
  }

  findAll(role: string): Promise<User[]> {
    return this.userModel.find({ roles: role }).exec();
  }

  async findOne(id: string): Promise<User> {
    const restaurant = await this.userModel.findById(id).exec();

    if (!restaurant) {
      throw new HttpException('Restaurant not found', HttpStatus.NOT_FOUND);
    }

    return restaurant;
  }

  //update username
  async updateUsername(id: string, updateUserDto: UpdateUserDto) {
    const { new_username } = updateUserDto;
    const user = await this.userModel.findOne({ _id: id });
    if (!user) {
      throw new BadRequestException('User not found');
    } else user.username = new_username;
    await user.save();

    return `your new username is ${new_username} `;
  }

  //update password
  async updatePassword(id: string, updateUserDto: UpdateUserDto) {
    const { old_password, new_password } = updateUserDto;
    const user = await this.userModel.findOne({ _id: id });
    if (!user) {
      throw new BadRequestException('User not found');
    }

    const isMatch = await bcrypt.compare(old_password, user.password);

    if (!isMatch) {
      throw new BadRequestException('Invalid credentials');
    } else {
      const new_hashedPassword = await bcrypt.hash(new_password, 10);
      user.password = new_hashedPassword;
    }
    await user.save();

    return `old password ${old_password}, new password ${new_password}`;
    // return 'your new password is saved'
  }

  async remove(id: string): Promise<string> {
    await this.userModel.deleteOne({ _id: id }).exec();
    return `Account Deleted Successfully`;
  }
}
