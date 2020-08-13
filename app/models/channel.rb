class Channel < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :users, -> { distinct }, through: :messages

  validates :name, presence: true, uniqueness: true

  def users_count
    users.count
  end
end
