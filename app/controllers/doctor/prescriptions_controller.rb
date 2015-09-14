class Doctor::PrescriptionsController < ApplicationController
  layout 'doctor_layout'
  skip_before_action :verify_authenticity_token
  before_filter :require_doctor_signin

  def new
    @consult = Consult.find(params[:consult_id])
    @parmacy = Prescription.new
  end

  def show
  end

  def index
  end

  def create
    @consult = Consult.find(params[:consult_id])
    @prescription = Prescription.create!(prescription_params)
    @consult.prescriptions << @prescription
    redirect_to finish_doctor_consult_path(@consult)
    rescue ActiveRecord::RecordInvalid => invalid
      flash[:error_messages] = invalid.record.errors.full_messages
      redirect_to new_doctor_consult_prescription_path(@consult)
  end


  protected
    def json_request?
      request.format.json?
    end

  private
    def prescription_params
      params.permit(:notes, :result, :name, :dosage)
    end

end
