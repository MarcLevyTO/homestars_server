class Message < ApplicationRecord
  belongs_to :user
  belongs_to :channel

  validates :message, presence: true
end
