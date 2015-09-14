class Patient::PharmaciesController < ApplicationController
  layout 'patient_layout'
  skip_before_action :verify_authenticity_token
  before_filter :require_patient_signin

  def new
    @consult = Consult.find(params[:consult_id])
    @consult.update_attributes(:patient_waiting => false)
    @pharmacy = Pharmacy.new
  end

  def show
  end

  def index
  end

  def create
    @consult = Consult.find(params[:consult_id])
    @pharmacy = Pharmacy.create!(pharmacy_params)
    @pharmacy.consults << @consult
    redirect_to finish_patient_consult_path(@consult)
    rescue ActiveRecord::RecordInvalid => invalid
      flash[:error_messages] = invalid.record.errors.full_messages
      redirect_to new_patient_consult_pharmacy_path(@consult)
  end


  protected
    def json_request?
      request.format.json?
    end

  private
    def pharmacy_params
      params.permit(:name, :place_id, :note)
    end

end
