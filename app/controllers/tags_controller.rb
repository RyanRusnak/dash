class TagsController < ApplicationController

  before_action :set_tag, only: [:show, :edit, :update, :destroy, :import]

  def index
    @tags = Tag.all
    render json: @tags
  end

  def show
    render json: @tag
  end

  def new
    @tag = Tag.new
  end

  def edit
  end

  def create
    @tag = Tag.new(tag_params)

      if @tag.save
        render json: @tag 
      else
        render json: @tag.errors, status: :unprocessable_entity 
      end
  end

  def update
      if @tag.update(tag_params)
        render json: @tag
      else
        render json: @tag.errors, status: :unprocessable_entity 
      end
  end

  def destroy
    @tag.destroy
    render json: 'error'
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    def set_tag
      @tag = Tag.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tag_params
      params.require(:tag).permit(:name, :description)
    end
end
