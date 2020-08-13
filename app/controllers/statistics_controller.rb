class StatisticsController < ApplicationController

  # @route     PUT /statistics/
  # @desc      Edit message in channel
  # @access    User
  # @params
  def get_stats
    num_users_total = User.count
    num_users_active = User.where(status: "Active").count
    user_data = User.all.as_json(methods: :messages_count)
    channel_data = Channel.all.as_json(methods: :users_count)

    render json: { num_users_total: num_users_total, 
      num_users_active: num_users_active, 
      user_data: user_data,
      channel_data: channel_data
    }
  end

end
