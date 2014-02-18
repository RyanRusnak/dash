class Category
	include Mongoid::Document

	require 'csv'
	belongs_to :group
	has_many :documents, :dependent => :destroy
  
	field :name, type: String

	def self.import(file, category)
	  csv = CSV.new(file.read, :headers => true, :header_converters => :symbol)
	  cats = csv.to_a.map {|row| 
	  	row.to_hash 
	  	category.documents.create({
	  		:name => row[:project_number], 
	  		:body => row[:abstract_text1].encode('utf-8', :invalid => :replace, :undef => :replace)})
	  }
	  return 'success'
	end

end
