import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { CommentsDTO } from 'src/dtos/comments/comment.dto';
import { NewCommentDTO } from 'src/dtos/comments/new.comment.dto';
import { CommentHelpdeskTickets } from 'src/entities/CommentHelpdeskTickets';
import { Comments } from 'src/entities/Comments';
import { ApiResponse } from 'src/misc/api.response.class';
import { Repository } from 'typeorm';

@Injectable()
export class CommentsService {
  constructor(
    @InjectRepository(Comments)
    private commentsrepo: Repository<Comments>,
    @InjectRepository(CommentHelpdeskTickets)
    private comenthelpdeskrepo: Repository<CommentHelpdeskTickets>,
  ) {}

  async getAllComments(): Promise<CommentsDTO[] | ApiResponse> {
    const commentData = await this.commentsrepo.find({
        relations: [
            "comments",
            "comments.user",
            "commentHelpdeskTickets"
        ]})
    const response: CommentsDTO[] = commentData.map((comment) => ({
        commentId: comment.commentId,
        text: comment.text,
        parentCommentId: comment.parentCommentId,
        createdAt: comment.createdAt,
        comments: (comment.comments || []).map((parentComment) => ({
            text: parentComment.text,
            createdAt: parentComment.createdAt,
            user: {
                fullname: parentComment.user.fullname
            }
        }))
    }))
    return response;
  }

  async createComment(commentDTO: NewCommentDTO): Promise<Comments | ApiResponse> {
    try {
        const newComment: Comments = new Comments();
        newComment.text = commentDTO.text;
        newComment.userId = commentDTO.userId;

        const savedComment = await this.commentsrepo.save(newComment);

        if (!savedComment) {
        throw new Error('Greška prilikom spašavanja komentara');
        }

        const newCommentHelpdeskTicket: CommentHelpdeskTickets = new CommentHelpdeskTickets();
        newCommentHelpdeskTicket.commentId = savedComment.commentId;
        newCommentHelpdeskTicket.ticketId = commentDTO.ticketId;

        const savedCommentHelpdeskTicket = await this.comenthelpdeskrepo.save(newCommentHelpdeskTicket);

        if (!savedCommentHelpdeskTicket) {
        throw new Error('Greška prilikom spašavanja veze komentara sa tiketom');
        }
          
        return await this.commentsrepo.findOne({
            where: { commentId: savedComment.commentId },
            relations: [
                'comments',
                'comments.user',
                'commentHelpdeskTickets',
                'commentHelpdeskTickets.comment',
                'commentHelpdeskTickets.ticket',
            ],
        });
      } catch (error) {
        console.error(error.message);
        return new ApiResponse('error', -1, 'Dogodila se greška prilikom kreiranja komentara.');
      }
    }

    async createReply(commentId: number, commentDTO: NewCommentDTO): Promise<Comments | ApiResponse> {
        try {
            const newComment: Comments = new Comments();
            newComment.text = commentDTO.text;
            newComment.parentCommentId = commentId;
            newComment.userId = commentDTO.userId;
    
            const savedComment = await this.commentsrepo.save(newComment);
    
            if (!savedComment) {
            throw new Error('Greška prilikom spašavanja komentara');
            }
              
            return await this.commentsrepo.findOne({
                where: { commentId: savedComment.commentId },
                relations: [
                    'comments',
                    'comments.user',
                    'commentHelpdeskTickets',
                    'commentHelpdeskTickets.comment',
                    'commentHelpdeskTickets.ticket',
                ],
            });
          } catch (error) {
            console.error(error.message);
            return new ApiResponse('error', -1, 'Dogodila se greška prilikom kreiranja komentara.');
          }
        }


  async getCommentById(commentId: number): Promise<Comments | ApiResponse> {
    return await this.commentsrepo.findOne({where: {commentId: commentId}});
  }

/*   async updateComment(commentId: number, commentDTO: CommentsDTO): Promise<Comments | undefined> {
    await this.commentsRepository.update(commentId, commentDTO);
    return await this.commentsRepository.findOne(commentId);
  } */

  async deleteComment(commentId: number): Promise<void> {
    await this.commentsrepo.delete(commentId);
  }
}
