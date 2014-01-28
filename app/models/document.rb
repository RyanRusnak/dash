class Document
  include Mongoid::Document

  belongs_to :category
  
  field :name, type: String
  field :body, type: String
end
