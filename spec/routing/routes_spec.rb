require 'spec_helper'

describe "classification route" do

  it "routes /classify_document to category controller action" do
    expect(:post => "/classify_document").to route_to(
      :controller => "categories",
      :action => "classify_document",
      :format => 'json'
    )
  end

  it "routes file import path to category controller action" do
    expect(:post => "/categories/1234/import").to route_to(
      :controller => "categories",
      :id => '1234',
      :action => "import"
    )
  end

end