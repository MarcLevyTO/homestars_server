class ChannelsController < ApplicationController
  before_action :authorized, only: [:create]

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

  private

  def channel_params
    params.permit(:name)
  end

end
