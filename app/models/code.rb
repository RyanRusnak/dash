class Code
  include Mongoid::Document

  belongs_to :document
  
  field :project_detail_id, type: String
  field :code, type: String
  field :strategic_plan_description, type: String
  field :strategic_plan_dollars, type: String

end
