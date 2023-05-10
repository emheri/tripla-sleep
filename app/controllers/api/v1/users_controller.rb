class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: %i[show update destroy]

  def index
    users = User.all

    render json: UserSerializer.new(users).serializable_hash.to_json
  end

  def show
    render json: UserSerializer.new(@user).serializable_hash.to_json
  end

  def create
    user = User.new(user_params)

    if user.save
      render json: UserSerializer.new(user).serializable_hash.to_json, status: :created
    else
      render json: { message: user.errors.messages }, status: :bad_request
    end
  end

  def update
    if @user.update(user_params)
      render json: UserSerializer.new(@user).serializable_hash.to_json
    else
      render json: { message: @user.errors.messages }, status: :bad_request
    end
  end

  def destroy
    if @user.destroy
      head :ok
    else
      render json: { message: @user.errors.messages }, status: :bad_request
    end
  end

  private

  def set_user
    @user = User.find params[:id]
  end

  def user_params
    params.require(:user).permit(:name)
  end
end
