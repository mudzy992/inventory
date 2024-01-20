import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { CommentsDTO } from 'src/dtos/comments/comment.dto';
import { NewCommentDTO } from 'src/dtos/comments/new.comment.dto';
import { Comments } from 'src/entities/Comments';
import { HelpdeskTickets } from 'src/entities/HelpdeskTickets';
import { ApiResponse } from 'src/misc/api.response.class';
import { Repository } from 'typeorm';
import { sendEmail } from '../email/send.email.service';

@Injectable()
export class CommentsService {
  constructor(
    @InjectRepository(Comments)
    private commentsrepo: Repository<Comments>,
    @InjectRepository(HelpdeskTickets)
    private ticketRepo: Repository<HelpdeskTickets>,
  ) {}

  async getAllComments(): Promise<CommentsDTO[] | ApiResponse> {
    const commentData = await this.commentsrepo.find({
        relations: [
            "comments",
            "comments.user",
            "comments.ticket",
        ]})
    const response: CommentsDTO[] = commentData.map((comment) => ({
        commentId: comment.commentId,
        text: comment.text,
        parentCommentId: comment.parentCommentId,
        createdAt: comment.createdAt,
        ticketId: comment.ticketId,
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
    const options: Intl.DateTimeFormatOptions = { year: 'numeric', month: 'numeric', day: 'numeric', hour: 'numeric', minute: 'numeric' };
    try {
        const newComment: Comments = new Comments();
        newComment.text = commentDTO.text;
        newComment.userId = commentDTO.userId;
        newComment.ticketId = commentDTO.ticketId;

        const ticket = await this.ticketRepo.findOne({
          where: {ticketId: commentDTO.ticketId},
          relations:["user"]
        })

        const emailSubject = `[#${commentDTO.ticketId}] - Agent potražuje informaciju`;
        const emailText = `
        Poštovani, \nvezano za Vaš zahtjev [#${commentDTO.ticketId}] koji ste prijavili ${ticket.createdAt.toLocaleDateString(undefined, options)}. godine.
        \nOpis zahtjeva: ${ticket.description}.
        \nAgent potražuje: ${commentDTO.text}`;
        await sendEmail(ticket.user.email, emailSubject, emailText);
        console.log(ticket.user.email)

        const savedComment = await this.commentsrepo.save(newComment);

        if (!savedComment) {
        throw new Error('Greška prilikom spašavanja komentara');
        }
          
        return await this.commentsrepo.findOne({
            where: { commentId: savedComment.commentId },
            relations: [
                'comments',
                'comments.user',
                'comments.ticket',
            ],
        });
      } catch (error) {
        console.error(error.message);
        return new ApiResponse('error', -1, 'Dogodila se greška prilikom kreiranja komentara.');
      }
    }

    async createReply(commentId: number, commentDTO: NewCommentDTO): Promise<Comments | ApiResponse> {
      const options: Intl.DateTimeFormatOptions = { year: 'numeric', month: 'numeric', day: 'numeric', hour: 'numeric', minute: 'numeric' };
      const masterComment = await this.commentsrepo.findOne({where: { commentId: commentId}, relations:['user']})
        try {
            const newComment: Comments = new Comments();
            newComment.text = commentDTO.text;
            newComment.parentCommentId = commentId;
            newComment.userId = commentDTO.userId;
            newComment.ticketId = commentDTO.ticketId;

            const emailSubject = `[#${commentDTO.ticketId}] - Odgovor na traženu informaciju`;
            const emailText = `
            Poštovani, \nvezano za Vaš potraživanje informacije na dan ${masterComment.createdAt.toLocaleDateString(undefined, options)}. godine.
            \Tražena informacija: ${masterComment.text}.
            \Klijent je odgovorio informaciju: ${commentDTO.text}`;
            await sendEmail(masterComment.user.email, emailSubject, emailText);
            console.log(masterComment.user.email)
            const savedComment = await this.commentsrepo.save(newComment);
    
            if (!savedComment) {
            throw new Error('Greška prilikom spašavanja komentara');
            }
              
            return await this.commentsrepo.findOne({
                where: { commentId: savedComment.commentId },
                relations: [
                    'comments',
                    'comments.user',
                    'comments.ticket',
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
