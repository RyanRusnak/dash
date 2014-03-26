class Post
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :document
  
  field :body, type: String

end
