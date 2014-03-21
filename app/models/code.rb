class Code
  include Mongoid::Document

  belongs_to :document
  
  field :code, type: String

end
