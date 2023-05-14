class Api::V1::FollowsController < ApplicationController
  before_action :set_user
  before_action :validate_params, only: %i[create destroy]
  before_action :set_followed_user, only: %i[create destroy]

  def create
    follow = @user.follow(@followed_user.id)
    if follow.save
      head :created
    else
      render json: { message: follow.errors.messages }, status: :bad_request
    end
  end

  def destroy
    if @user.unfollow(@followed_user.id)
      head :ok
    else
      render json: { message: 'User not following' }, status: :bad_request
    end
  end

  def following
    render json: UserSerializer.new(@user.following).serializable_hash.to_json
  end

  def followers
    render json: UserSerializer.new(@user.followers).serializable_hash.to_json
  end

  def sleep
    sleeps = FollowSleepQuery.new(user: @user).following_previous_week_sleeps

    render json: UserSerializer.new(sleeps).serializable_hash.to_json
  end

  private

  def set_user
    @user = User.find params[:user_id]
  end

  def set_followed_user
    @followed_user = User.find follow_params[:following_id]
  end

  def follow_params
    params.permit(:following_id)
  end

  def validate_params
    return if params[:following_id].present?

    render_unprocessable_entity(StandardError.new('following_id is required')) and return
  end
end
