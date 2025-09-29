class PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :destroy, :toggle_like]

  # GET /posts
  def index
    posts = Post.all
    render json: posts
  end

  # GET /posts/:id
  def show
    render json: @post
  end

  # POST /posts
  def create
    post = Post.new(post_params)
    if post.save
      render json: post, status: :created
    else
      render json: { errors: post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PUT /posts/:id
  def update
    if @post.update(post_params)
      render json: @post
    else
      render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /posts/:id
  def destroy
    @post.destroy
    head :no_content
  end

  # PATCH /posts/:id/toggle_like
  def toggle_like
    @post.update(is_liked: !@post.is_liked)
    render json: @post
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :is_liked)
  end
end
