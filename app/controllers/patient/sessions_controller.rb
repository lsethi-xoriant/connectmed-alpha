class Patient::SessionsController < ApplicationController
  layout "empty"
  before_action :require_patient_signin, :only => :destroy

  def new
  end

  def create
    @patient = Patient.find_by(email: params[:session][:email].downcase)
    if @patient && @patient.authenticate(params[:session][:password])
      if @patient.email_confirmed
        patient_sign_in(@patient)
        redirect_to patient_dashboard_path
      else
        flash[:error_message] = 'Please activate your account by following the
        instructions in the account confirmation email you received to proceed'
        redirect_to patient_signin_path
      end
    else
      flash[:error_messages] = 'Invalid email/password combination'
      redirect_to patient_signin_path
    end
  end

  def destroy
    patient_sign_out
    redirect_to '/'
  end

end
