import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  UsePipes,
  ValidationPipe,
} from '@nestjs/common';
import { AuthService } from './auth.service';
import { SignUpDto } from './dto/signup.auth.dto';
import { LoginDto } from './dto/login.auth.dto';

@Controller('auth')
export class AuthController {
  constructor(private authService: AuthService) {}

  @Post('/signup')
  @UsePipes(new ValidationPipe())
  signUp(@Body() signUpDto: SignUpDto) {
    return this.authService.signUp(signUpDto);
  }

  @Post('/login')
  @UsePipes(new ValidationPipe())
  login(@Body() loginDto: LoginDto) {
    return this.authService.login(loginDto);
  }
  // @Delete(':id')
  // remove(@Param('id') id: string) {
  //   return this.authService.remove(+id);
  // }
  @Get('/logout')
  logout(){
    return this.authService.logout()
  }
}
