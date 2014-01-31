require 'spec_helper'

describe "classification route" do
  it "routes /classify_document to controller action" do
    expect(:post => "/classify_document").to route_to(
      :controller => "categories",
      :action => "classify_document",
      :format => 'json'
    )
  end

end