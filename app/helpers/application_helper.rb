module ApplicationHelper
  def is_active_controller(controller_name)
      params[:controller] == controller_name ? "active" : nil
  end

  def is_active_action(action_name)
      params[:action] == action_name ? "active" : nil
  end

  def patient_sign_in(patient)
    remember_token = Patient.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    patient.update_attribute(:remember_token, Patient.digest(remember_token))
    self.current_patient = patient
  end

  def patient_signed_in?
    !current_patient.nil?
  end

  def current_patient=(patient)
    @current_patient = patient
  end

  def current_patient
    remember_token = Patient.digest(cookies[:remember_token])
    @current_patient ||= Patient.find_by(remember_token: remember_token)
  end

  def patient_sign_out
    patient_has_left #just in case AJAX to designate patient has left doesn't work
    current_patient.update_attribute(:remember_token, Patient.digest(Patient.new_remember_token))
    cookies.delete(:remember_token)
    self.current_patient = nil
  end

  def require_patient_signin
    unless patient_signed_in?
      redirect_to root_path
    end
  end

  def patient_has_left
    current_patient.consults.last.update_attributes(:patient_waiting => false);
  end

  def doctor_sign_in(doctor)
    remember_token = Doctor.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    doctor.update_attribute(:remember_token, Doctor.digest(remember_token))
    self.current_doctor = doctor
  end

  def doctor_signed_in?
    !current_doctor.nil?
  end

  def current_doctor=(doctor)
    @current_doctor = doctor
  end

  def current_doctor
    remember_token = Doctor.digest(cookies[:remember_token])
    @current_doctor ||= Doctor.find_by(remember_token: remember_token)
  end

  def doctor_sign_out
    current_doctor.update_attribute(:remember_token, Doctor.digest(Doctor.new_remember_token))
    cookies.delete(:remember_token)
    self.current_doctor = nil
  end

  def require_doctor_signin
    unless doctor_signed_in?
      redirect_to '/doctor'
    end
  end
end
