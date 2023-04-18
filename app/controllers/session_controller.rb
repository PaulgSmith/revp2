require_relative '../../lib/json_web_token'
require_relative '../models/personnel'

class SessionController < ApplicationController

  def create
    credentials = JSON.parse(request.body.read)
    user = Personnel.where(username: credentials['userName']).first

    if user&.authenticate(credentials['password'])
      @token = JsonWebToken.encode(user_id: user.id)
      if LoginToken.where(personnel_id: user.id).first
        LoginToken.where(personnel_id: user.id).first.update(token: @token)
      else
        LoginToken.create(token: @token, personnel_id: user.id)
      end
      logger.info "User #{user.username} logged in"
      render json: { token: @token, user_title: user.title, user_id: user.id, username: user.username, name: user.name}, status: :created
    else
      logger.info "User #{credentials['userName']} failed to log in"
      render json: { error: 'Invalid username/password' }, status: :unauthorized
    end
  end
end

