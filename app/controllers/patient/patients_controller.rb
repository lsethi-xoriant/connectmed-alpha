class Patient::PatientsController < ApplicationController
  layout "patient_layout"
  before_filter :require_patient_signin, :except => [:new, :create, :confirm_email]

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
    if params[:patient][:directed_from] == "home"
      PatientMailer.registration_confirmation(@patient).deliver
      redirect_to("/#create-confirm")
    else
      patient_sign_in(@patient)
      redirect_to patient_dashboard_path
    end
    rescue ActiveRecord::RecordInvalid => invalid
      flash[:error_messages] = invalid.record.errors.full_messages
      params[:patient][:directed_from] == "home" ? redirect_to("/#create-error") : redirect_to(patient_signup_path)
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
      current_patient.update_attribute(:first_name, patient_params[:first_name])
      current_patient.update_attribute(:last_name, patient_params[:last_name])
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

  def confirm_email
      @patient = Patient.find_by_confirm_token(params[:id])
      if @patient
        @patient.email_activate
        redirect_to("/#confirm-email")
        # redirect_to("/patient/signin#confirm-email") #Use this post launch
      else
        redirect_to("/#confirm-error")
      end
  end

  def schedule_confirm
    @patient = current_patient
  end

  private

  def patient_params
    params.require(:patient).permit(:first_name, :last_name, :email, :phone, :age, :gender, :password, :password_confirmation, :password_digest, :remember_token, :source, :directed_from)
  end


end
