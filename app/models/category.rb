class Category
	include Mongoid::Document

	has_many :documents
  
	field :name, type: String

	def say_true
		true
	end

end
