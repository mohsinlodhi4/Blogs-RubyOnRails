module Api
    class PostsController < ApplicationController
        # Exception Handling Start
        rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
        rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
        # Exception Handling End

        def index
            @posts = Post.includes(:replies).order(created_at: :desc)
            render json: {message: "Posts fetched successfully", data: @posts}, status: :ok
        end
        
        def show
            render json: {message: "Post fetched successfully", data: Post.includes(:replies).find(params[:id]) }, status: :ok
        end

        def create
            post = Post.create!(post_params)
            render json: {message: "Posts created successfully", data: post}, status: :created
        end

        def update
            post = Post.find(params[:id])
            post.update!(post_params)
            render json: { message: "Post Edited successfully" }, status: :ok

          end

        def destroy
            Post.find(params[:id]).destroy
            render json: { message: "Post Deleted successfully" }, status: :ok
        end
        
        private
        
        def post_params
            params.permit(:title, :body)
        end
        # Exception Handling Methods Start
        def render_not_found_response
            render json: { error: "Post Not Found" }, status: :not_found
        end
        
        def render_unprocessable_entity_response(invalid)
            render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
        end
        # Exception Handling Methods End

    end
end
