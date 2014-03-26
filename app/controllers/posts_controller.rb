class PostsController < ApplicationController

  before_action :set_document, only: [:index, :create, :show, :edit, :update, :destroy]
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = @document.posts.all
    render json: @posts
  end

  def show
    render json: @post
  end

  def new
    @post = post.new
  end

  def edit
  end

  def create
    @post = @document.posts.new(post_params)

      if @post.save
        render json: @post 
      else
        render json: @post.errors, status: :unprocessable_entity 
      end
  end

  def update
      if @post.update(post_params)
        render json: @post
      else
        render json: @post.errors, status: :unprocessable_entity 
      end
  end

  def destroy
    @post.destroy
    render json: 'error'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:document_id])
    end

    def set_post
      @post = @document.posts.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:body)
    end
end
