class ChannelsController < ApplicationController
  before_action :authorized, only: [:create, :show, :join]

  # @route     GET /channels
  # @desc      List all channels
  # @access    Public
  # @params
  def index
    @channels = Channel.all
    render json: @channels
  end

  # @route     POST /channels
  # @desc      Create new channel
  # @access    User
  # @params    name
  def create
    return render json: { error: 'missing name' }, status: :bad_request if channel_params[:name].blank?

    @channel = Channel.new(channel_params)
    if @channel.save
      render json: @channel, status: :created
    else
      render json: @channel.errors, status: :unprocessable_entity
    end
  end

  # @route     GET /channels/:id
  # @desc      Create new channel
  # @access    User
  # @params    withMessages
  def show
    @channel = Channel.find(params[:id])
    return render json: @channel.errors, status: :unprocessable_entity if @channel.blank?
    render json: @channel.to_json(:include => [:users, :messages])
  end

  # @route     POST /channels/:id/join
  # @desc      Join new channel (sends an introduction method to the channel)
  # @access    User
  # @params
  def join
    @channel = Channel.find(params[:id])
    return render json: @channel.errors, status: :unprocessable_entity if @channel.blank?
    return render json: { error: 'Already joined' }, status: :method_not_allowed if @channel.users.include?(@user)

    new_message = Message.new(user_id: @user.id, channel_id: @channel.id, message: "#{@user.username} has joined the channel!")
    if new_message.save
      render json: new_message
    else
      render json: new_message.errors, status: :unprocessable_entity
    end
  end

  # @route     DELETE /channels/:id
  # @desc      Join new channel (sends an introduction method to the channel)
  # @access    User (should be an admin level user or the user who made the channel)
  # @params
  def delete
    @channel = Channel.find(params[:id])
    return render json: @channel.errors, status: :unprocessable_entity if @channel.blank?
    @channel.status = "Archived"
    if @channel.save
      render json: @channel
    else
      render json: @channel.errors, status: :unprocessable_entity
    end
  end


  private

  def channel_params
    params.permit(:name)
  end

end
