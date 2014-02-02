require "spec_helper"
require 'nbayes'

describe Category do

  it "it parses a CSV" do
  	@category = Category.create({:name => 'test cat'})
  	@file = Rack::Test::UploadedFile.new("#{Rails.root}/public/files/1A-2013.csv", "text/csv")
    expect(Category.import(@file, @category)).to eq('success')
  end

end