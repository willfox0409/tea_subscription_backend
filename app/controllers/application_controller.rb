rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
rescue_from ActionController::ParameterMissing, with: :render_bad_request

private

def render_not_found(error)
  render json: { error: error.message }, status: :not_found
end

def render_bad_request(error)
  render json: { error: error.message }, status: :bad_request
end

def render_unprocessable_entity(error)
  render json: { error: error.message }, status: :unprocessable_entity
end

# TODO: Swap in ErrorSerializer if we build out custom error responses
