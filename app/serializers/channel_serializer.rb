class ChannelSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :messages
  attribute :users do |room|
    UserSerializer.new(room.users.uniq)
  end
end