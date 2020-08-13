require 'rails_helper'

RSpec.describe Channel, type: :model do
  let!(:user) { User.create(username: "marclevy", password: "123Password1!") }
  let!(:channel) { Channel.create(name: "Channel 1") }
  
  subject { Message.new(user_id: user.id, channel_id: channel_id, message: "Insert message here") }
  before { subject.save }

  it 'user_id should be present' do
    subject.user_id = nil
    expect(subject).to_not be_valid
  end

  it 'channel_id should be present' do
    subject.channel_id = nil
    expect(subject).to_not be_valid
  end

  it 'message should be present' do
    subject.message = nil
    expect(subject).to_not be_valid
  end

end