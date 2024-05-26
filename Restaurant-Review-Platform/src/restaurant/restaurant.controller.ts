import {
  Body,
  Controller,
  Delete,
  Get,
  NotFoundException,
  Param,
  Post,
  Put,
  Query,
  Req,
  UseGuards,
} from '@nestjs/common';
import { UpdateRestaurantDto } from './dto/update-restaurant.dto';
import { CreateRestaurantDto } from './dto/create-restaurant.dto';
import { RestaurantService } from './restaurant.service';
import { Restaurant } from 'src/schemas/restaurant.schema';
import { Request } from 'express';
import { RolesGuard } from 'src/auth/guards/roles.guard';
import { AuthGuard } from 'src/auth/guards/auth.guard';
import { Query as ExpressQuery } from 'express-serve-static-core';
import { Roles } from 'src/auth/decorators/roles.decorator';
import { UserRole } from 'src/auth/enums/roles.enum';

@Controller('restaurant')
export class RestaurantController {
  constructor(private readonly restaurantService: RestaurantService) {}

  @Get()
  @UseGuards(AuthGuard, RolesGuard)
  async getRestaurants(@Query() query: ExpressQuery): Promise<Restaurant[]> {
    return this.restaurantService.getRestaurants(query);
  }

  @Get(':id')
  @UseGuards(AuthGuard, RolesGuard)
  async getRestaurant(@Param('id') id: string): Promise<Restaurant> {
    try {
      return this.restaurantService.getRestaurant(id);
    } catch (e) {
      throw new NotFoundException(e.message);
    }
  }

  @Post()
  @UseGuards(AuthGuard, RolesGuard)
  @Roles(UserRole.OWNER)
  async createRestaurant(
    @Body() createRestaurantDto: CreateRestaurantDto,
    @Req() request: Request,
  ): Promise<Restaurant> {
    createRestaurantDto.ownerId = request.user['sub'];

    return this.restaurantService.createRestaurant(createRestaurantDto);
  }

  @Put(':id')
  @UseGuards(AuthGuard, RolesGuard)
  @Roles(UserRole.OWNER)
  async updateRestaurant(
    @Param('id') id: string,
    @Req() request: Request,
    @Body() updateRestaurantDto: UpdateRestaurantDto,
  ): Promise<Restaurant> {
    return this.restaurantService.updateRestaurant(
      id,
      request.user['sub'],
      updateRestaurantDto,
    );
  }

  @Delete(':id')
  @UseGuards(AuthGuard, RolesGuard)
  @Roles(UserRole.OWNER)
  async removeRestaurant(
    @Param('id') id: string,
    @Req() request: Request,
  ): Promise<Restaurant> {
    return this.restaurantService.removeRestaurant(id, request.user['sub']);
  }
}
