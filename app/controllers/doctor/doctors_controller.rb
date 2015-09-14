class Doctor::DoctorsController < ApplicationController
  layout "doctor_layout"
  before_filter :require_doctor_signin, :except => [:new, :create]

  def dashboard
    @consults_waiting = Consult.where(patient_waiting: true);
    puts 'consults waiting'
  end

  def privacy_policy
  end

  def new
    @doctor = Doctor.new
    render :layout => "empty"
  end

  def create
    @doctor = Doctor.create!(doctor_params)
    doctor_sign_in(@doctor)
    redirect_to doctor_dashboard_path
    rescue ActiveRecord::RecordInvalid => invalid
      flash[:error_messages] = invalid.record.errors.full_messages
      redirect_to doctor_signup_path
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
      current_doctor.update_attribute(:name, doctor_params[:name])
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



  private

  def doctor_params
    params.require(:doctor).permit(:name, :email, :phone, :password, :password_confirmation, :password_digest, :remember_token)
  end


end
