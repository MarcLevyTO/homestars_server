class MessagesController < ApplicationController
  before_action :authorized, only: [:create, :update]

  # @route     POST /messages
  # @desc      Create new message in channel
  # @access    User
  # @params    channel_id, message
  def create
    if message_params[:message].blank? || message_params[:channel_id].blank?
      return render json: { error: 'missing data' }, status: :bad_request
    end

    message = Message.new(user_id: @user.id, message: message_params[:message], channel_id: message_params[:channel_id])
    channel = Channel.find(message_params[:channel_id])
    if message.save
      ChannelChannel.broadcast_to(channel, {
        channel: ChannelSerializer.new(channel),
        users: UserSerializer.new(channel.users),
        messages: MessageSerializer.new(channel.messages)
      })
      # render json: MessageSerializer.new(message)
      render json: message
    else
      render json: message.errors, status: :unprocessible_entity
    end
  end

  # @route     PUT /messages/:id
  # @desc      Edit message in channel
  # @access    User
  # @params    message
  def update
    return render json: { error: 'missing message' }, status: :unprocessible_entity if message_params[:message].nil?
    message = Message.find(params[:id])
    message.message = message_params[:message]
    message.status = 'Edited'
    message.save
    render json: message
  end

  # @route     DELETE /messages/:id
  # @desc      Delete message in channel (set status to 'Deleted')
  # @access    User
  # @params    message
  def delete
    return render json: { error: 'missing message' } status: :unprocessible_entity if message_params[:message].nil?
    message = Message.find(params[:id])
    message.status = 'Deleted'
    message.save
    render json: message, status: :accepted
  end

  private

  def message_params
    params.permit(:message, :channel_id)
  end

end
