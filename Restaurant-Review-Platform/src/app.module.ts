import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { AuthModule } from './auth/auth.module';
import { MongooseModule } from '@nestjs/mongoose';
import { UsersModule } from './users/users.module';
import { RolesGuard } from './auth/guards/roles.guard';
import { JwtService } from '@nestjs/jwt';
import { RestaurantModule } from './restaurant/restaurant.module';
import { CommentModule } from './comment/comment.module';
import { AdminFuncModule } from './admin_func/admin_func.module';

@Module({
  imports: [
    AuthModule,
    MongooseModule.forRoot('mongodb://127.0.0.1:27017/restaurant-review'),
    UsersModule,
    RestaurantModule,
    CommentModule,
    AdminFuncModule,
  ],
  controllers: [AppController],
  providers: [
    AppService,
    {
      provide: 'APP_GUARD',
      useClass: RolesGuard,
    },
    JwtService,
  ],
})
export class AppModule {}
