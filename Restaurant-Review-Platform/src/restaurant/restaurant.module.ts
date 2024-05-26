import { Module } from '@nestjs/common';
import { RestaurantController } from './restaurant.controller';
import { RestaurantService } from './restaurant.service';
import { MongooseModule } from '@nestjs/mongoose';
import { Restaurant, RestaurantSchema } from 'src/schemas/restaurant.schema';
import { JwtService } from '@nestjs/jwt';
import { AuthGuard } from 'src/auth/guards/auth.guard';

@Module({
  imports: [
    MongooseModule.forFeature([
      { name: Restaurant.name, schema: RestaurantSchema },
    ]),
  ],
  controllers: [RestaurantController],
  providers: [RestaurantService, JwtService, AuthGuard],
})
export class RestaurantModule {}
