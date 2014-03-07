class Category
	include Mongoid::Document

	require 'csv'
	belongs_to :group
	# has_many :documents, :dependent => :destroy
  
	field :name, type: String

	def self.import(file, category)
	  csv = CSV.new(file.read, :headers => true, :header_converters => :symbol)
	  cats = csv.to_a.map {|row| 
	  	row.to_hash 
	  	logger.debug(row);
	  	body = row[:abstract_text1].encode('utf-8', :invalid => :replace, :undef => :replace) unless row[:abstract_text1].blank?
	  	category.documents.create({
	  		:name => row[:project_number], 
	  		:body => body,
		  	:appl_id => row[:appl_id],
		  	:project_number => row[:project_number],
		  	:fut_yrs=> row[:fut_yrs],
		  	:project_period_start_date => row[:project_period_start_date],
		  	:project_period_end_date => row[:project_period_end_date],
		  	:appl_period_start_date => row[:appl_period_start_date],
		  	:appl_period_end_date => row[:appl_period_end_date],
		  	:expire_fy => row[:expire_fy],
		  	:sub_project => row[:sub_project],
		  	:project => row[:project],
		  	:obligated_total_cost_amt => row[:obligated_total_cost_amt]
		})
	  }
	  return 'success'
	end

end
