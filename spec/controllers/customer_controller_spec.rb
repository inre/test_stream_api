require 'rails_helper'

RSpec.describe CustomerController, type: :controller do
  it "get views" do
    get :views, params: { customer_id: 2 }
    expect(JSON.parse(response.body)).to eq({ "views" => 0})
  end
end
