class Doctor::DoctorsController < ApplicationController
  layout "doctor_layout"
  before_filter :require_doctor_signin, except: [:new, :create,:confirm_email]

  def dashboard
    @consults_waiting = Consult.where(patient_waiting: true).order("created_at ASC");
  end

  def privacy_policy
  end

  def new
    @doctor = Doctor.new
    render :layout => "empty"
  end

  def create
    @doctor = Doctor.create!(doctor_params)
    if params[:doctor][:directed_from] == "home"
      DoctorMailer.registration_confirmation(@doctor).deliver
      redirect_to("/doctor/#create-confirm")
    else
      doctor_sign_in(@doctor)
      redirect_to doctor_dashboard_path
    end
    rescue ActiveRecord::RecordInvalid => invalid
      flash[:error_messages] = invalid.record.errors.full_messages
      params[:doctor][:directed_from] == "home" ? redirect_to("/doctor/#create-error") : redirect_to(doctor_signup_path)
  end

  def destroy
    doctor_sign_out
    redirect_to '/'
  end

  def edit
  end

  def update
    if current_doctor.update(doctor_params)
      redirect_to doctor_edit_path
      flash[:success_messages] = "Your Account Details Have Been Updated"
    elsif doctor_params[:password].empty?
      current_doctor.update_attribute(:first_name, doctor_params[:first_name])
      current_doctor.update_attribute(:last_name, doctor_params[:last_name])
      current_doctor.update_attribute(:email, doctor_params[:email])
      current_doctor.update_attribute(:phone_number, doctor_params[:phone_number])
      redirect_to doctor_edit_path
      flash[:success_messages] = "Your Account Details Have Been Updated"
    else
      begin
      current_doctor.update!(doctor_params)
      rescue ActiveRecord::RecordInvalid => invalid
        flash[:error_messages] = invalid.record.errors.full_messages
        redirect_to doctor_edit_path
      end
    end
  end

def confirm_email
      @doctor = Doctor.find_by_confirm_token(params[:id])
      if @doctor
        @doctor.email_activate
        redirect_to("/doctor/#confirm-email")
        # redirect_to("/doctor/signin#confirm-email") #Use this post launch
      else
        redirect_to("/doctor/#confirm-error")
      end
  end

  def schedule_confirm
    @doctor = current_doctor
  end


  private

  def doctor_params
    params.require(:doctor).permit(:first_name, :last_name, :email, :phone, :password, :password_confirmation, :password_digest, :remember_token, :practice_number, :source, :directed_from)
  end


end
