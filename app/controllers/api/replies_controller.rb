module Api
    class RepliesController < ApplicationController
        # Exception Handling Start
        rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
        rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
        # Exception Handling End
        before_action :set_post, only: [:create, :index]
        before_action :set_reply, only: [:show, :update, :destroy]

        def create
            @post = Post.find(params[:post_id])
            @reply = @post.replies.build(reply_params)
        
            if @reply.save
            render json: { message: "Reply saved succssfully", data: @reply }, status: :ok
            else
                render json: { message: "Reply could not be saved" }, status: :unprocessable_entity
            end
        end

        def index
            @post = Post.find(params[:post_id])
            @replies = @post.replies
            render json: { message: "Replies fetched successfully", data: @replies }, status: :ok
        end

        def show
            render json: { message: "Reply fetched successfully", data: @reply }, status: :ok
        end
    
        def update
            if @reply.update(reply_params)
                render json: { message: "Reply updated successfully", data: @reply }, status: :ok
            else
                render json: { message: "Reply could not be updated", errors: @reply.errors }, status: :unprocessable_entity
            end
        end
    
        def destroy
            @reply.destroy
            render json: { message: "Reply deleted successfully" }, status: :ok
        end

        private
        def set_post
            @post = Post.find(params[:post_id])
        end
    
        def set_reply
            @reply = Reply.find(params[:id])
        end
    
        def reply_params
            params.permit(:content)
        end
        # Exception Handling Methods Start
        def render_not_found_response
            render json: { error: "Reply Not Found" }, status: :not_found
        end
        
        def render_unprocessable_entity_response(invalid)
            render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
        end
        # Exception Handling Methods End

    end
end