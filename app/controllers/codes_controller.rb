class CodesController < ApplicationController

  before_action :set_document, only: [:show, :edit, :update, :destroy]
  before_action :set_code, only: [:show, :edit, :update, :destroy, :import]

  def index
    @codes = Code.all
    render json: @codes
  end

  def show
    render json: @code
  end

  def new
    @code = Code.new
  end

  def edit
  end

  def create
    @code = Code.new(code_params)

      if @code.save
        render json: @code 
      else
        render json: @code.errors, status: :unprocessable_entity 
      end
  end

  def update
      if @code.update(code_params)
        render json: @code
      else
        render json: @code.errors, status: :unprocessable_entity 
      end
  end

  def destroy
    @code.destroy
    render json: 'error'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:document_id])
    end

    def set_code
      @code = @documemnt.codes.find(params[:code_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def code_params
      params.require(:code).permit(:name, :description)
    end
end
