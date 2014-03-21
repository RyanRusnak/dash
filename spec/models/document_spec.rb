require 'spec_helper'

describe Document do

  it "it parses a CSV" do

  	@file = Rack::Test::UploadedFile.new("#{Rails.root}/public/project_table_sample.csv", "text/csv")
    expect(Document.import(@file)).to eq('success')
  end

end
