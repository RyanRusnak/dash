class Abstract
  include Mongoid::Document

  belongs_to :document
	  
  field :fy, type: String
  field :project_num, type: String
  field :abstract_text, type: String

end
