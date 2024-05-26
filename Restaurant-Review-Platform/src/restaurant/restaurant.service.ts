/* eslint-disable prettier/prettier */
import { Injectable, HttpException, HttpStatus, BadRequestException } from '@nestjs/common';
import { Restaurant, RestaurantDocument } from 'src/schemas/restaurant.schema';
import { CreateRestaurantDto } from './dto/create-restaurant.dto';
import { UpdateRestaurantDto } from './dto/update-restaurant.dto';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { Query } from 'express-serve-static-core';


@Injectable()
export class RestaurantService {
  constructor(
    @InjectModel(Restaurant.name)
    private restaurantModel: Model<RestaurantDocument>,
  ) {}

  async getRestaurants(query: Query): Promise<Restaurant[]> {

    const resPerPage = 20;
    const currentPage = Number(query.page) || 1;
    const skip = resPerPage * (currentPage - 1);



    const keyword = query.keyword ? {
      name: {
        $regex: query.keyword,
        $options: 'i',
      },
    } : {};

    const ownerId = query.ownerId ? {ownerId: query.ownerId} : {};
    
    const restaurants = await this.restaurantModel.find({ ...keyword, ...ownerId }).populate("comments").limit(resPerPage).skip(skip).exec();

    return restaurants;
  }

  async getRestaurant(id: string): Promise<Restaurant> {
    const restaurant = await this.restaurantModel.findById(id).populate('comments').exec();

    if (!restaurant) {
      throw new HttpException('Restaurant not found', HttpStatus.NOT_FOUND);
    }

    return restaurant;
  }

  async createRestaurant(
    createRestaurantDto: CreateRestaurantDto,
  ): Promise<Restaurant> {
    const newRestaurant = new this.restaurantModel(createRestaurantDto);
    return newRestaurant.save();
  }

  async updateRestaurant(
    id: string,
    ownerId: string,
    updateRestaurantDto: UpdateRestaurantDto,
  ): Promise<Restaurant> {
    const restaurant = await this.restaurantModel.findById(id).exec();
    if (!restaurant) {
      throw new HttpException('Restaurant not found', HttpStatus.NOT_FOUND);
    }

    if (restaurant.ownerId !== ownerId) {
      throw new HttpException('You can only update your own restaurants', HttpStatus.UNAUTHORIZED);
    }

    return await this.restaurantModel
    .findByIdAndUpdate(id, updateRestaurantDto, { new: true })
    .exec();;
  }

  async removeRestaurant(id: string, ownerId: string): Promise<Restaurant> {
    const tobeRemoved = await this.restaurantModel.findById(id).exec();
    if (!tobeRemoved) {
      throw new HttpException('Restaurant not found', HttpStatus.NOT_FOUND);
    }

    if (tobeRemoved.ownerId !== ownerId) {
      throw new HttpException('You can only update your own restaurants', HttpStatus.UNAUTHORIZED)
    }

    await this.restaurantModel.findByIdAndDelete(id).exec();
    return tobeRemoved;
  }
}
