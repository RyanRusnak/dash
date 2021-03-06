class DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :edit, :update, :destroy]


  # GET /documents
  # GET /documents.json
  def index
    @documents = Document.where(:submitted => "submitted")
    total_cost = @documents.map{|e| e.aids_dollars.to_i}.reduce(:+)

    constraint = params[:with] rescue nil
    constrained_by = params[:constrain_by] rescue nil
    review_type = params[:review_type] rescue nil

    case constrained_by
      when "year_expiring"
        @docs_with_expire = Document.where({:expire_fy => { "$ne" => nil }, :submitted => "submitted"})
        @documents = Document.short_list(@docs_with_expire, "expire_fy")
      when "additional_submissions"
        @add_docs = Document.where(:submitted => "additional year")
        @documents = Document.tag_list(@add_docs, "tags")
      when "year_expiring_verbose"
        @documents = @documents.group_by{|document|
          document.project_period_end_date.to_date.year rescue nil
        }
      when "year_expiring_dollars"
        @docs_with_expire = Document.where({:expire_fy => { "$ne" => nil }, :submitted => "submitted"})
        @documents = Document.short_list_dollars(@docs_with_expire, "expire_fy")
      when "year_starting"
        @documents = Document.short_list(@documents, "project_period_start_date")
      when "year_starting_verbose"
        @documents = @documents.group_by{|document|
          document.project_period_start_date.to_date.year rescue nil
        }
      when "paginate"
        @documents = @documents.all.take(100)
      when "year"
        @documents = {:documents => @documents.where({:expire_fy => constraint}).take(100)}
      when "code"
        code_docs = Document.includes(:codes).select { |d|
            d.codes.each {|c|
              c.code == constraint
          }
        }
        @documents = {:documents => code_docs.take(100)}
      when "all_tags"
        @documents = Document.tag_list(@documents, "tags")
      when "tag"
        tag = Tag.find(constraint) rescue nil
        if (!tag)
          tag = Tag.where(:name => constraint)[0]
        end
        tagged_docs = Document.any_in(:tags => {"id"=>tag.id.to_s,"text"=>tag.name})
        tagged_docs.select{|d|
          d.status = review_type
        }
        docs_cost = tagged_docs.map{|e| e.aids_dollars.to_i}.reduce(:+)
        @documents = {
          :documents =>tagged_docs,
          :cost => docs_cost,
          :percent_of_budget =>((docs_cost.to_f/total_cost.to_f)*100).round(2)
        }
      when "status"
        if (constraint)
          @documents = Document.where(:status => constraint, :submitted => "submitted")
          @documents = {:documents => Document.tag_list(@documents, "tags")}
        else
          @documents = Document.short_list(@documents, "status")
        end
      when "last_updated"
        @documents = {:documents =>Document.last_updated(@documents.includes(:posts), "updated_at")}
      else
      end

      respond_to do |format|
        format.html { render "index" }
        format.json { render json: @documents }
      end
  end

  # GET /documents/1
  # GET /documents/1.json
  def show
    constraint = params[:with] rescue nil
    constrained_by = params[:constrain_by] rescue nil

    case constrained_by
    when "code"
      @codes = @document.codes.map { |c|
        {:label => c.code, :value => c.strategic_plan_dollars}
      }
      render json: @codes
    else
      render json: @document
    end
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
    tagHash = JSON.parse(document_params[:tags])
    doc = document_params
    doc[:tags]= tagHash
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

  def import
    if (Document.import(params[:file])) == "success"
      render json: "success"
    else
      render json: "error"
    end
  end

  def code_import
    if (Document.code_import(params[:file])) == "success"
      render json: "success"
    else
      render json: "error"
    end
  end

  def abstract_import
    if (Document.abstract_import(params[:file])) == "success"
      render json: "success"
    else
      render json: "error"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_params
      params.require(:document).permit(:project_title, :tags)
    end
end
