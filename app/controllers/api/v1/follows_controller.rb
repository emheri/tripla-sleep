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
    users = @user.following
                 .joins(:sleeps)
                 .where('sleep_at >= ?', Date.current - 7.days)
                 .select('users.*, sleeps.duration AS sleep_duration')
                 .order('sleeps.duration DESC')

    render json: UserSerializer.new(users).serializable_hash.to_json
  end

  def followers
    users = @user.followers
                 .joins(:sleeps)
                 .where('sleep_at >= ?', Date.current - 7.days)
                 .select('users.*, sleeps.duration AS sleep_duration')
                 .order('sleeps.duration DESC')

    render json: UserSerializer.new(users).serializable_hash.to_json
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
