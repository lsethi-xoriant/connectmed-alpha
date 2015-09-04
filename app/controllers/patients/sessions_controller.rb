class Patients::SessionsController < ApplicationController
  layout "empty"

  def new
  end

  def create
    @patient = Patient.find_by(email: params[:session][:email].downcase)
    if @patient && @patient.authenticate(params[:session][:password])
      patient_sign_in(@patient)
      redirect_to patients_dashboard_path
    else
      flash[:error_messages] = 'Invalid email/password combination'
      redirect_to patients_signin_path
    end
  end

  def destroy
    patient_sign_out
    redirect_to '/'
  end

end
