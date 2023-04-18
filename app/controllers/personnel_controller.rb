require_relative 'concerns/authenticate'

class PersonnelController < ApplicationController
  include Authenticate
  def index
    if current_user.title.to_i == 1
      render json: { personnel: Personnel.all }, status: :ok
    else
      render json: {personnel: Personnel.where(id: current_user.id)}, status: :ok
    end
  end

  def create
    if current_user.title.to_i == 1
      new_personnel = Personnel.new(JSON.parse(request.body.read))
      begin
        if new_personnel.save
          render json:, status: :created
        else
          render json: {message: 'Invalid personnel creation'}, status: :bad_request
        end
        rescue StandardError => e
      end
      logger.info "Personnel created: #{new_personnel.inspect} created by #{current_user.inspect}"
    else
      logger.info "Personnel creation failed: #{new_personnel.inspect} attempted by #{current_user.inspect}"
      render json: {message: 'Invalid token'}, status: :unauthorized
    end
  end

  def show
    #fix if not there errors
    personnel = Personnel.where(id: params[:id]).first
    if personnel
      if personnel.id == current_user.id || current_user.title.to_i == 1
        render json: {personnel: personnel}, status: :ok
      else
        render json: {message: 'Invalid token'}, status: :forbidden
      end
    else
      render json: {message: "Personnel with id #{params[:id]} not found"}, status: :not_found
    end

  end


  def update
    personnel = Personnel.where(id: params[:id]).first
    if personnel
      begin
        if personnel.id == current_user.id || current_user.title.to_i == 1
          personnel.update(JSON.parse(request.body.read))
          render json: {}, status: :no_content
        else
          render json: {message: 'Invalid token'}, status: :forbidden
        end
      rescue StandardError => e
      end
      logger.info "Personnel updated: #{personnel.inspect} updated by #{current_user.inspect}"
    else
      logger.info "Personnel update failed: #{personnel.inspect} attempted by #{current_user.inspect}"
      render json: {message: "Personnel with id #{params[:id]} not found"}, status: :not_found
    end
  end

  def destroy
    if current_user.title.to_i == 1
      personnel = Personnel.where(id: params[:id]).first
      if personnel
        @id = personnel.id
        begin
          if current_user.title.to_i == 1
            personnel.destroy
            render json: {}, status: :no_content
          else
            render json: {message: 'Invalid token'}, status: :forbidden
          end
        rescue StandardError => e
        end
        logger.info "Personnel deleted: #{personnel.inspect} deleted by #{current_user.inspect}"
      else
        render json: {message: "Personnel with id #{params[:id]} not found"}, status: :not_found
      end
    else
      logger.info "Personnel deletion failed: #{personnel.inspect} attempted by #{current_user.inspect}"
      render json: {message: 'Invalid token'}, status: :unauthorized
    end
  end

end