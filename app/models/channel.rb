class Channel < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :users, through: :messages

  validates :name, uniqueness: true
end
