import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { HydratedDocument, Schema as samiSchema } from 'mongoose';
import { Restaurant } from './restaurant.schema';

export type CommentDocument = HydratedDocument<Comment>;

@Schema()
export class Comment {
  @Prop()
  opinion: string;

  @Prop({ type: String, ref: 'User' })
  userId: string;

  @Prop({ type: String, ref: 'User' })
  username: string;

  @Prop({ type: samiSchema.Types.ObjectId, ref: 'Restaurant' })
  restaurantId: samiSchema.Types.ObjectId;
}

export const CommentSchema = SchemaFactory.createForClass(Comment);
