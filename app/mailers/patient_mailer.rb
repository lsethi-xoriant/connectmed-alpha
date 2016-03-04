class PatientMailer < ActionMailer::Base
  default from: "no-reply@connectmed.co.za"

  def registration_confirmation(patient)
    @patient = patient
    mail(:to => "#{@patient.name} <#{@patient.email}>", :subject => "Registration Confirmation")
  end

end
