class ApplicationController < ActionController::API
  def decode_token(token)
    JWT.decode(token, ENV['JWT_SECRET_KEY'], true, { algorithm: 'HS256' })
  rescue JWT::DecodeError
    nil
  end

  # リクエストからトークンを取得し、ユーザーを認証
  def authenticate_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    decoded = decode_token(header)
    if decoded
      @current_employee = Employee.find(decoded[0]['employee_id'])
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
end
