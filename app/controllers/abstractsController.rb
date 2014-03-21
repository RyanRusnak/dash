class AbstractsController < ApplicationController

  before_action :set_document, only: [:show, :edit, :update, :destroy]
  before_action :set_abstract, only: [:show, :edit, :update, :destroy]

  def index
    @abstracts = @document.abstracts.all
    render json: @abstracts
  end

  def show
    # render json: @abstract
  end

  def new
    @abstract = Abstract.new
  end

  # def edit
  # end

  # def create
  #   @abstract = @document.abstracts.new(abstract_params)

  #     if @abstract.save
  #       render json: @abstract 
  #     else
  #       render json: @abstract.errors, status: :unprocessable_entity 
  #     end
  # end

  # def update
  #     if @abstract.update(abstract_params)
  #       render json: @abstract
  #     else
  #       render json: @abstract.errors, status: :unprocessable_entity 
  #     end
  # end

  # def destroy
  #   @abstract.destroy
  #   render json: 'error'
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:document_id])
    end

    def set_abstract
      @abstract = @document.abstracts.find(params[:abstract_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def abstract_params
      params.require(:abstract).permit(:name, :description)
    end
end
