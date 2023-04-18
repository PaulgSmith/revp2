require_relative 'concerns/authenticate'

class ReimbursementController < ApplicationController
  include Authenticate

  def index
    if current_user.title.to_i == 1
      render json: ReimbursementRequest.all, status: :ok
    else
      render json: ReimbursementRequest.where(personnel_id: current_user.id), status: :ok
    end
  end

  def create
     new_reimbursement = ReimbursementRequest.new(JSON.parse(request.body.read).merge(personnel_id: current_user.id).except('id').except('manager_id').except('status'))
     begin
      if new_reimbursement.save
        render json: new_reimbursement, status: :ok
         else
        render json: {message: 'Invalid reimbursement request'}, status: :bad_request
        end
           rescue StandardError => e
     end
     logger.info "Reimbursement request created successfully for #{new_reimbursement.personnel_id}"
     end

  def show
    reimbursement = ReimbursementRequest.where(id: params[:id]).first
    if reimbursement
      if current_user.id == reimbursement.personnel_id || current_user.title.to_i == 1
        render json: reimbursement, status: :ok
      else
        render json: {message: 'Invalid token'}, status: :forbidden
      end
      else
        render json: {message: "Reimbursement request with id #{params[:id]} not found"}, status: :not_found
    end
  end

    def update
    reimbursement = ReimbursementRequest.where(id: params[:id]).first
    if reimbursement
      if current_user.id == reimbursement.personnel_id
        if reimbursement.update(JSON.parse(request.body.read).except('id').except('manager_id').except('status').except('personnel_id').except('manager_comment'))
          render json: reimbursement, status: :ok
          logger.info "Reimbursement request updated successfully for #{reimbursement.personnel_id}, request made by #{current_user.id}"
        else
          render json: {message: 'Invalid reimbursement request'}, status: :bad_request
        end
      elsif current_user.title.to_i == 1
        if reimbursement.update(JSON.parse(request.body.read).merge(manager_id: current_user.id).except('id').except('personnel_id').except('subject').except('request_amount').except('request'))
          render json: reimbursement, status: :ok
          logger.info "Reimbursement request updated successfully for #{reimbursement.personnel_id}, request made by #{current_user.id}"
        end
      else
        logger.info "Reimbursement request updated failed for #{reimbursement.personnel_id}, request made by #{current_user.id}"
        render json: {message: 'Invalid token'}, status: :forbidden
      end
    else
      render json: {message: "Reimbursement request with id #{params[:id]} not found"}, status: :not_found
    end

  end

  def destroy
    reimbursement = ReimbursementRequest.where(id: params[:id]).first
    if reimbursement
      if current_user.title.to_i == 1 || current_user.id == reimbursement.personnel_id
        reimbursement.destroy
        render json: {}, status: :no_content
        else
        render json: {message: 'Invalid token'}, status: :forbidden
        end
      else
      render json: {message: "Reimbursement request with id #{params[:id]} not found"}, status: :not_found
      end

    end
  end
