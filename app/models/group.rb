class Group
  include Mongoid::Document

  has_many :categories, :dependent => :destroy

  field :name, type: String
  
end
