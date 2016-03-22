class DoctorMailer < ActionMailer::Base
  default from: "allan@connectmed.co.za"
  require 'open-uri'

  def registration_confirmation(doctor)
    @doctor = doctor
    mail(:to => "#{@doctor.first_name} #{@doctor.last_name} <#{@doctor.email}>", :subject => "ConnectMed Registration - Please Confirm Your Email Address")
  end

  def scheduled_consult_confirmation(consult,slot,doctor)
    @consult = consult
    @slot = slot
    @doctor = doctor
    mail(:to => "#{@doctor.first_name} #{@doctor.last_name} <#{@doctor.email}>", :subject => "ConnectMed Consult Confirmation #{@slot.time.strftime('%a %b %d %H:%M')}")
  end

  def consult_followup_email(doctor,consult,prescription)
    @doctor = doctor
    @consult = consult
    @prescription = prescription
    attachments["#{@prescription.image_file_name}"] =  open("#{@prescription.image.path}").read
    mail(:to => "#{@doctor.first_name} #{@doctor.last_name} <#{@doctor.email}>", :subject => "ConnectMed Consultation Followup & Prescription")
  end

  # def scheduled_reminder_email(doctor,slot,doctor)

  # end

end
