/* eslint-disable prettier/prettier */
export class CreateRestaurantDto {
  name: string;
  description: string;
  location: string;
  contact: string;
  openingTime: string;
  closingTime: string;
  ownerId: string;
  comments: string[];
}
