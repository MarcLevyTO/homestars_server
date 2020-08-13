class SearchController < ApplicationController
  before_action :authorized, only: [:search]

  # @route     GET /search
  # @desc      Search for users or channels
  # @access    User
  # @params    text
  def search
    return render json: { error: "text not found" }, status: bad_request if params[:text].blank?
    users = User.where("username like ?", "%#{params[:text]}%")
    channels = Channel.where("name like ?", "%#{params[:text]}%")
    render json: { users: users, channels: channels }
  end

end
