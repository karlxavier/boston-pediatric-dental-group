class PatientMailer < ApplicationMailer
     default from: "care@bostonpdg.com"

     def welcome_mail(patient)
          @patient = patient
          mail(to: @patient.email, subject: 'Welcome Email')
     end
end
