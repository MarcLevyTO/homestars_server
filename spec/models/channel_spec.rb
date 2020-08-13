require 'rails_helper'

RSpec.describe Channel, type: :model do
  subject { Channel.new(name: "Channel 1") }
  before { subject.save }

  it 'name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'name should not be duplicate' do
    # 
  end

end