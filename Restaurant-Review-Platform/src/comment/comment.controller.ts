import {
  Controller,
  Get,
  Post,
  Body,
  Param,
  Delete,
  NotFoundException,
  Put,
  UseGuards,
  Req,
} from '@nestjs/common';
import { CommentService } from './comment.service';
import { CreateCommentDto } from './dto/create-comment.dto';
import { UpdateCommentDto } from './dto/update-comment.dto';
import { Comment } from 'src/schemas/comment.schema';
import { Request } from 'express';
import { AuthGuard } from 'src/auth/guards/auth.guard';
import { RolesGuard } from 'src/auth/guards/roles.guard';
import { Roles } from 'src/auth/decorators/roles.decorator';
import { UserRole } from 'src/auth/enums/roles.enum';

@Controller('comment')
export class CommentController {
  constructor(private readonly commentService: CommentService) {}

  @Get()
  @UseGuards(AuthGuard, RolesGuard)
  async getComments(): Promise<Comment[]> {
    return this.commentService.getComments();
  }

  @Get(':id')
  @UseGuards(AuthGuard, RolesGuard)
  async getComment(@Param('id') id: string): Promise<Comment> {
    try {
      return await this.commentService.getComment(id);
    } catch (error) {
      throw new NotFoundException(error.message);
    }
  }

  @Post()
  @UseGuards(AuthGuard, RolesGuard)
  @Roles(UserRole.USER)
  async createComment(
    @Body() createCommentDto: CreateCommentDto,
    @Req() request: Request,
  ): Promise<Comment> {
    createCommentDto.userId = request.user['sub'];
    createCommentDto.username = request.user['username'];
    return this.commentService.createComment(createCommentDto);
  }

  @Put(':id')
  @UseGuards(AuthGuard, RolesGuard)
  @Roles(UserRole.USER)
  async updateComment(
    @Param('id') id: string,
    @Body() updateCommentDto: UpdateCommentDto,
    @Req() request: Request,
  ): Promise<Comment> {
    return this.commentService.updateComment(
      id,
      request.user['sub'],
      updateCommentDto,
    );
  }

  @Delete(':id')
  @UseGuards(AuthGuard, RolesGuard)
  @Roles(UserRole.USER)
  async removeComment(
    @Param('id') id: string,
    @Req() request: Request,
  ): Promise<Comment> {
    return this.commentService.removeComment(id, request.user['sub']);
  }
}
