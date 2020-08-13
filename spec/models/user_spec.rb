require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(username: "marclevy", password: "123Password1!") }
  before { subject.save }

  it 'username should be present' do
    subject.username = nil
    expect(subject).to_not be_valid
  end

  it 'username should not be duplicate' do
    # 
  end

  it 'password should be present' do
    subject.password = nil
    expect(subject).to_not be_valid
  end

  it 'password should contain at least one lower case letter' do
    subject.password = "123PASSWORD1!"
    expect(subject).to_not be_valid
    # expect(subject.errors).to contain(" must contain at least one lowercase letter")
  end

  it 'password should contain at least one uppercase letter' do
    subject.password = "123password1!"
    expect(subject).to_not be_valid
    # expect(subject.errors).to contain(" must contain at least one uppercase letter")
  end

  it 'password should contain at least one digit' do
    subject.password = "Password!"
    expect(subject).to_not be_valid
    # expect(subject.errors).to contain("  must contain at least one digit")
  end

  it 'password contain at least one special character' do
    subject.password = "123Password1"
    expect(subject).to_not be_valid
    # expect(subject.errors).to contain(" must contain at least one special character")
  end
end