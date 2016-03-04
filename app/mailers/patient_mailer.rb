class PatientMailer < ActionMailer::Base
  default from: "no-reply@connectmed.co.za"

  def registration_confirmation(patient)
    @patient = patient
    mail(:to => "#{@patient.name} <#{@patient.email}>", :subject => "ConnectMed Registration - Please Confirm Your Email Address")
  end

end
