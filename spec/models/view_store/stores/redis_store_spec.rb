require "rails_helper"

RSpec.describe ViewsStore::Stores::LocalStore do
  subject do
    ViewsStore::Stores::RedisStore.new(
      url: "redis://localhost:6379/0",
      prefix: "test:",
      timeout: 1
    )
  end

  it "touches the store" do
    k1 = 1
    k2 = 2
    subject.touch(k1, 1)
    subject.touch(k1, 2)
    subject.touch(k2, 1)
    expect(subject.size_of(k1)).to be 2
    expect(subject.size_of(k2)).to be 1
  end

  it "cut off old values" do
    k1 = 1
    subject.touch(k1, 1)
    subject.touch(k1, 2)
    expect(subject.size_of(k1)).to be 2

    sleep 2

    subject.cleanup_all
    expect(subject.size_of(k1)).to be 0
  end
end
