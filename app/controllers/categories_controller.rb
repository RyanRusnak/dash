class CategoriesController < ApplicationController

  before_action :set_group, except: [:classify_document]
  before_action :set_category, only: [:show, :edit, :update, :destroy, :import]

  # GET /categories
  # GET /categories.json
  def index
    @categories = @group.categories.all
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = @group.categories.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to group_category_path(@group, @category), notice: 'Category was successfully created.' }
        format.json { render action: 'show', status: :created, location: @category }
      else
        format.html { render action: 'new' }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to group_category_path(@group, @category), notice: 'Category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to group_path(@group) }
      format.json { head :no_content }
    end
  end

  def classify_document
    @nbayes = NBayes::Base.new
    @group = Group.find(params[:id])
    @group.categories.each do |cat| 
      cat.documents.each do |doc|
        @nbayes.train(doc.body.split(/\s+/), cat.name )
      end
    end 

    logger.debug(@nbayes.inspect)

    doc = params[:doc].to_s.split(/\s+/)
    logger.debug('-----');
    logger.debug(params[:doc]);
    logger.debug(doc.inspect);
    result = @nbayes.classify(doc)

    logger.debug(result.inspect)

    classify_hash = {:max_class=> result.max_class, :probability => result.to_json}
    respond_to do |format|
        format.json { render json: classify_hash.to_json }
    end
  end

  def import
    Category.import(params[:file], @category)
    redirect_to group_category_path(@group, @category), notice: "Documents successfully imported."
  end

  private
    def set_group
      @group = Group.find(params[:group_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = @group.categories.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name)
    end

end
