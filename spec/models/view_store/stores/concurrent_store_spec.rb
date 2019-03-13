require "rails_helper"

RSpec.describe ViewsStore::Stores::ConcurrentStore do
  subject do
    ViewsStore::Stores::ConcurrentStore.new(timeout: 0)
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
    subject.timeout = 5
    k1 = 1
    allow(subject).to receive(:current_time).and_return(10)
    subject.touch(k1, 1)
    allow(subject).to receive(:current_time).and_return(15)
    subject.touch(k1, 2)
    expect(subject.size_of(k1)).to be 2

    allow(subject).to receive(:current_time).and_return(20)
    subject.cleanup_all
    expect(subject.size_of(k1)).to be 1
  end
end
