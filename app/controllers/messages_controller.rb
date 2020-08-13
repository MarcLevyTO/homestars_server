class MessagesController < ApplicationController
  before_action :authorized, only: [:create, :update, :delete, :search]

  # @route     POST /messages
  # @desc      Create new message in channel
  # @access    User
  # @params    channel_id, message
  def create
    if message_params[:message].blank? || message_params[:channel_id].blank?
      return render json: { error: "missing data" }, status: :bad_request
    end

    channel = Channel.find(message_params[:channel_id])
    return render json: { error: "channel is archived, no new messages allowed" }, status: :forbidden if channel.status == "Archived"

    message = Message.new(user_id: @user.id, message: message_params[:message], channel_id: message_params[:channel_id])
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
    return render json: { error: "missing message" }, status: :unprocessible_entity if message_params[:message].nil?
    @message = Message.find(params[:id])
    return render json: @channel.errors, status: :unprocessable_entity if @message.blank?
    
    @message.message = message_params[:message]
    @message.status = "Edited"
    if @message.save
      render json: @message
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  # @route     DELETE /messages/:id
  # @desc      Delete message in channel (set status to "Deleted")
  # @access    User
  # @params
  def delete
    @message = Message.find(params[:id])
    return render json: @channel.errors, status: :unprocessable_entity if @channel.blank?
    @message.status = "Deleted"
    if @message.save
      render json: @message
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  # @route     GET /messages/search
  # @desc      Search for message by message text
  # @access    User
  # @params    text
  def search
    return render json: { error: "text not found" }, status: bad_request if params[:text].blank?
    results = @user.messages.where("message like ?", "%#{params[:text]}%")
    render json: results
  end

  private

  def message_params
    params.permit(:message, :channel_id)
  end

end
