class AuthenticationController < ApplicationController
  def login
    @employee = Employee.find_by(name: params[:name])
    if @employee&.authenticate(params[:password])
      # 有効な認証情報の場合、JWTトークンを生成
      token = encode_token({ employee_id: @employee.id })
      response.headers['Authorization'] = token
      head :ok
      # レスポンスボディにjwtトークンを設定するパターン
      # render json: { token: token }, status: :ok
    else
      render json: { error: 'Invalid credentials' }, status: :unauthorized
    end
  end

  private

  def encode_token(payload)
    # JWTトークンのエンコード
    # 秘密鍵とアルゴリズムを指定
    expiration = 1.hour.from_now.to_i
    JWT.encode(payload.merge(exp: expiration), ENV['JWT_SECRET_KEY'], 'HS256')
  end
end
