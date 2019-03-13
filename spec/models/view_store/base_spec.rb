require "rails_helper"

RSpec.describe ViewsStore::Base do
  class TestStore < ViewsStore::Base
  end

  it "sets store" do
    TestStore.store = "my_store"
    expect(TestStore.new.store).to eq "my_store"
  end
end
