class PatientMailerPreview < ActionMailer::Preview
  def sample_mail_preview
    PatientMailer.registration_confirmation(Patient.first)
  end
end
