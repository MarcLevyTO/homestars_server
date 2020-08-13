class MessageSerializer
  include FastJsonapi::ObjectSerializer
  attributes :user_id, :channel_id, :message
end