require 'rails_helper'

RSpec.describe VideoController, type: :controller do
  it "visit a video" do
    get :visit, params: { video_id: 7, customer_id: 3 }
    expect(response.status).to eq(200)
  end

  it "get views" do
    get :views, params: { video_id: 1 }
    expect(JSON.parse(response.body)).to eq({ "views" => 0})
  end
end
