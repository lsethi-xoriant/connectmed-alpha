class PatientMailer < ActionMailer::Base
  default from: "info@connectmed.co.za"
  require 'open-uri'

  def registration_confirmation(patient)
    @patient = patient
    mail(:to => "#{@patient.name} <#{@patient.email}>", :subject => "ConnectMed Registration - Please Confirm Your Email Address")
  end

  def scheduled_consult_confirmation(consult,slot,patient)
    @consult = consult
    @slot = slot
    @patient = patient
    mail(:to => "#{@patient.name} <#{@patient.email}>", :subject => "ConnectMed Consult Confirmation #{@slot.time.strftime('%a %b %d %H:%M')}")
  end

  def consult_followup_email(patient,consult,prescription)
    @patient = patient
    @consult = consult
    @prescription = prescription
    attachments["#{@prescription.image_file_name}"] =  open("#{@prescription.image.path}").read
    mail(:to => "#{@patient.name} <#{@patient.email}>", :subject => "ConnectMed Consultation Followup & Prescription")
  end

  # def scheduled_reminder_email(patient,slot,patient)

  # end

end
