import { Module } from '@nestjs/common';
import { CommentService } from './comment.service';
import { CommentController } from './comment.controller';
import { MongooseModule } from '@nestjs/mongoose';
import { Comment, CommentSchema } from 'src/schemas/comment.schema';
import { JwtService } from '@nestjs/jwt';
import { AuthGuard } from 'src/auth/guards/auth.guard';
import { RestaurantModule } from 'src/restaurant/restaurant.module';
import { Restaurant, RestaurantSchema } from 'src/schemas/restaurant.schema';

@Module({
  imports: [
    MongooseModule.forFeature([
      { name: Comment.name, schema: CommentSchema },
      { name: Restaurant.name, schema: RestaurantSchema },
    ]),
    RestaurantModule,
  ],
  controllers: [CommentController],
  providers: [CommentService, JwtService, AuthGuard],
})
export class CommentModule {}
