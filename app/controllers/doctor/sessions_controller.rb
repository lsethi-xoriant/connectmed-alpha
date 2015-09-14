class Doctor::SessionsController < ApplicationController
  layout "empty"
  before_action :require_doctor_signin, :only => :destroy

  def new
  end

  def create
    @doctor = Doctor.find_by(email: params[:session][:email].downcase)
    if @doctor && @doctor.authenticate(params[:session][:password])
      doctor_sign_in(@doctor)
      redirect_to doctor_dashboard_path
    else
      flash[:error_messages] = 'Invalid email/password combination'
      redirect_to doctor_signin_path
    end
  end

  def destroy
    doctor_sign_out
    redirect_to '/doctor'
  end

end
