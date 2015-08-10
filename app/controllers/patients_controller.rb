class PatientsController < ApplicationController
  layout "layout_3"

  def dashboard
    render :layout => "layout_2"
  end

  def new
    @patient = Patient.new
    render :layout => "empty"
  end

  def create
    @provider = Patient.create!(patient_params)
      redirect_to patients_dashboard_path
    rescue ActiveRecord::RecordInvalid => invalid
      flash[:error_messages] = invalid.record.errors.full_messages
      redirect_to new_patient_path
  end

  def destroy
    patient_sign_out
    redirect_to '/'
  end

  def update
    # patient = Patient.find(params[:id])
    # if patient.update(patient_params)
    #   redirect_to patient_patients_path
    # elsif patient_params[:password].empty?
    #   patient.update_attribute(:name, patient_params[:name])
    #   patient.update_attribute(:email, patient_params[:email])
    #   patient.update_attribute(:phone_number, patient_params[:phone_number])
    #   redirect_to patient_patients_path
    # else
    #   begin
    #   patient.update!(patient_params)
    #   rescue ActiveRecord::RecordInvalid => invalid
    #     flash[:error_messages] = invalid.record.errors.full_messages
    #     redirect_to edit_patient_patient_path(patient)
    #   end
    # end
  end



  private

  def patient_params
    params.require(:patient).permit(:name, :email, :phone, :password, :password_confirmation, :password_digest, :remember_token)
  end


end
