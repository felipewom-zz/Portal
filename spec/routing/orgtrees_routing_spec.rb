require "spec_helper"

describe OrgtreesController do
  describe "routing" do

    it "routes to #index" do
      get("/orgtrees").should route_to("orgtrees#index")
    end

    it "routes to #new" do
      get("/orgtrees/new").should route_to("orgtrees#new")
    end

    it "routes to #show" do
      get("/orgtrees/1").should route_to("orgtrees#show", :id => "1")
    end

    it "routes to #edit" do
      get("/orgtrees/1/edit").should route_to("orgtrees#edit", :id => "1")
    end

    it "routes to #create" do
      post("/orgtrees").should route_to("orgtrees#create")
    end

    it "routes to #update" do
      put("/orgtrees/1").should route_to("orgtrees#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/orgtrees/1").should route_to("orgtrees#destroy", :id => "1")
    end

  end
end
