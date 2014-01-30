require "spec_helper"
require 'nbayes'

describe Category do

  it "it returns true" do
  	c= Category.create({:name=>'Ryan'})
    expect(c.say_true).to eq(true)
  end

end