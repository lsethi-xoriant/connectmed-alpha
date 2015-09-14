class Patient::PatientsController < ApplicationController
  layout "patient_layout"
  before_filter :require_patient_signin, :except => [:new, :create]

  def dashboard
  end

  def privacy_policy
  end

  def new
    @patient = Patient.new
    render :layout => "empty"
  end

  def create
    @patient = Patient.create!(patient_params)
    patient_sign_in(@patient)
    redirect_to patient_dashboard_path
    rescue ActiveRecord::RecordInvalid => invalid
      flash[:error_messages] = invalid.record.errors.full_messages
      redirect_to patient_signup_path
  end

  def destroy
    patient_sign_out
    redirect_to '/'
  end

  def edit
  end

  def update
    if current_patient.update(patient_params)
      redirect_to patient_edit_path
      flash[:success_messages] = "Your Account Details Have Been Updated"
    elsif patient_params[:password].empty?
      current_patient.update_attribute(:name, patient_params[:name])
      current_patient.update_attribute(:email, patient_params[:email])
      current_patient.update_attribute(:phone_number, patient_params[:phone_number])
      redirect_to patient_edit_path
      flash[:success_messages] = "Your Account Details Have Been Updated"
    else
      begin
      current_patient.update!(patient_params)
      rescue ActiveRecord::RecordInvalid => invalid
        flash[:error_messages] = invalid.record.errors.full_messages
        redirect_to patient_edit_path
      end
    end
  end



  private

  def patient_params
    params.require(:patient).permit(:name, :email, :phone, :age, :gender, :password, :password_confirmation, :password_digest, :remember_token)
  end


end
