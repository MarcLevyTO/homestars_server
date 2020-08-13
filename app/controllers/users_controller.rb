class UsersController < ApplicationController
  before_action :authorized, only: [:profile]

  # @route     POST /users
  # @desc      Register new user
  # @access    Public
  # @params    username, password
  def create
    @user = User.create(user_params)
    if @user.valid?
      token = encode_token({user_id: @user.id})
      render json: {user: @user, token: token}
    else
      render json: {errors: @user.errors}, status: :unprocessable_entity
    end
  end

  # @route     POST /login
  # @desc      Fetch user JWT token
  # @access    Public
  # @params    username, password
  def login
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      token = encode_token({user_id: @user.id})
      render json: {user: @user, token: token}
    else
      render json: {error: "Invalid username or password"}
    end
  end

  # @route     POST /profile
  # @desc      Fetch user's profile
  # @access    User
  # @params
  def profile
    render json: @user
  end

  private

  def user_params
    params.permit(:username, :password)
  end

end