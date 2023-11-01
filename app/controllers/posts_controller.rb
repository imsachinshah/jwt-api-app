class PostsController < ApplicationController
 	before_action :set_post, only: [:show, :update, :destroy]

	def index
		@posts = @current_user.posts 

		if @posts 
			render json: PostSerializer.new(@posts).serializable_hash, status: :ok
		else
			render json: {errors: @posts.errors}
		end
	end

	def create
		@post = @current_user.posts.new(post_params)

		if @post.save
			render json: PostSerializer.new(@post).serializable_hash, status: :created
		else
			render json: @post.errors, status: :unprocessable_entity
		end
	end

	def show
		render json: PostSerializer.new(@post).serializable_hash, status: :ok
	end	

	def update
		if @post.update(post_params)
			render json: PostSerializer.new(@post).serializable_hash, status: :ok
		else
			render json: @post.errors, status: :unprocessable_entity
		end
	end

	def destroy
	  @post.destroy
		render json: {message: "#{@post.title} deleted successfully"}, status: :ok
	end


	private
		def post_params
			params.require(:post).permit(:title, :desc)
		end

		def set_post
			begin
				@post = @current_user.posts.find(params[:id])
			rescue ActiveRecord::RecordNotFound => e
				render json: {errors: e.message}, status: :bad_request
			end
		end

end
