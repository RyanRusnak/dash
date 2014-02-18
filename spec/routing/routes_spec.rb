require 'spec_helper'

describe "classification route" do

  it "routes /groups/:id/categories/classify_document to category controller action" do
    expect(:post => "/groups/1234/classify_document").to route_to(
      :format => "json",
      :controller => "categories",
      :action => "classify_document",
      :id => "1234",
    )
  end

  it "routes file import path to category controller action" do
    expect(:post => "/groups/1234/categories/1234/import").to route_to(
      :controller => "categories",
      :group_id => "1234",
      :id => '1234',
      :action => "import"
    )
  end

end