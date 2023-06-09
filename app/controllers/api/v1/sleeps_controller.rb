class Api::V1::SleepsController < ApplicationController
  before_action :set_user

  def index
    sleeps = @user.sleeps.order(sleep_at: :desc)

    render json: SleepSerializer.new(sleeps).serializable_hash.to_json
  end

  def sleep
    context = SleepServices::Sleep.call(record: @user)

    if context.success?
      head :ok
    else
      render_unprocessable_entity(context.exception)
    end
  end

  def wake
    context = SleepServices::Wake.call(record: @user)

    if context.success?
      head :ok
    else
      render_unprocessable_entity(context.exception)
    end
  end

  private

  def set_user
    @user = User.find params[:user_id]
  end
end
