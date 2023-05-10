module Response
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
    rescue_from ActionController::ParameterMissing, with: :render_unprocessable_entity
  end

  def render_unprocessable_entity(exception)
    render json: { message: exception.message }, status: :unprocessable_entity
  end

  def render_not_found(exception)
    render json: { message: exception.message }, status: :not_found
  end
end