class Document
  include Mongoid::Document

  
  field  :name, type: String
  field  :body, type: String
  field  :appl_id, type: String
  field  :project_number, type: String
  field  :fut_yrs, type: String
  field  :project_period_start_date, type: String
  field  :project_period_end_date, type: String
  field  :appl_period_start_date, type: String
  field  :appl_period_end_date, type: String
  field  :expire_fy, type: String
  field  :sub_project, type: String
  field  :project, type: String
  field  :obligated_total_cost_amt, type: String
  field  :codes, type: Array
  field  :tags, type: Array

  def self.short_list(documents, att_name)
    documents = documents.group_by{ |document|
          document.read_attribute(att_name).to_date.year rescue nil
        }
        totals = []
        documents.keys.each do |key|
          sub = {}
          sub[:label] = key
          sub[:value] = documents[key].count
          totals << sub
        end
        @documents = totals
  end

end
