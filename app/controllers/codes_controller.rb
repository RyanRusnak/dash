class CodesController < ApplicationController


  before_action :set_code, only: [:show, :edit, :update, :destroy, :import]

  def index
    @codes = Code.all
    render json: @codes
  end

  def show
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
    def set_code
      @code = Code.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def code_params
      params.require(:code).permit(:name, :description)
    end
end
