class DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :edit, :update, :destroy]
  

  # GET /documents
  # GET /documents.json
  def index
    @documents = Document.all
    total_cost = @documents.map{|e| e.obligated_total_cost_amt.to_i}.reduce(:+)

    case params[:type]
      when "year_expiring"
        @documents = Document.short_list(@documents, "project_period_end_date")
      when "year_expiring_verbose"
        @documents = @documents.group_by{|document|
          document.project_period_end_date.to_date.year rescue nil
        }
      when "year_starting"
        @documents = Document.short_list(@documents, "project_period_start_date")
      when "year_starting_verbose"
        @documents = @documents.group_by{|document|
          document.project_period_start_date.to_date.year rescue nil
        }
      when "paginate"
        @documents = @documents.all.take(100)
      when "by_code"
        code_docs = Document.any_in(:codes => {"id"=>params[:code],"text"=>params[:code_name]})
        docs_cost = code_docs.map{|e| e.obligated_total_cost_amt.to_i}.reduce(:+)
        @documents = {:documents=> code_docs, 
        :cost=> docs_cost, 
        :percent_of_budget=>((docs_cost.to_f/total_cost.to_f)*100).round(2)}
      else 
        
      end

    render json: @documents
  end

  # GET /documents/1
  # GET /documents/1.json
  def show
    render json: @document
  end

  # GET /documents/new
  def new
    @document = Document.new
  end

  # GET /documents/1/edit
  def edit
  end

  # POST /documents
  # POST /documents.json
  def create
    @document = Document.new(document_params)

    respond_to do |format|
      if @document.save
        # format.html { redirect_to group_category_document_path(@group, @category, @document), notice: 'Document was successfully created.' }
        format.json { render action: 'show', status: :created, location: @document }
      else
        # format.html { render action: 'new' }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /documents/1
  # PATCH/PUT /documents/1.json
  def update
    codeHash = JSON.parse(document_params[:codes])
    doc = document_params
    doc[:codes]= codeHash
    respond_to do |format|
      if @document.update(doc)
        # format.html { redirect_to group_category_document_path(@group, @category, @document), notice: 'Document was successfully updated.' }
        format.json { head :no_content }
      else
        # format.html { render action: 'edit' }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document.destroy
    respond_to do |format|
      # format.html { redirect_to group_category_path(@group, @category) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_params
      params.require(:document).permit(:name, :body, :type, :codes)
    end
end
