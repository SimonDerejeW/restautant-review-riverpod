import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { HydratedDocument, Schema as samiSchema } from 'mongoose';
import { Comment } from './comment.schema';

export type RestaurantDocument = HydratedDocument<Restaurant>;

@Schema()
export class Restaurant {
  @Prop()
  name: string;

  @Prop()
  description: string;

  @Prop()
  location: string;

  @Prop()
  contact: string;

  @Prop()
  openingTime: string;

  @Prop()
  closingTime: string;

  @Prop({ type: String, ref: 'User' })
  ownerId: string;

  @Prop({ type: [{ type: samiSchema.Types.ObjectId, ref: 'Comment' }] })
  comments: Comment[];

  @Prop({ default: false })
  isBanned: boolean;
}

export const RestaurantSchema = SchemaFactory.createForClass(Restaurant);
