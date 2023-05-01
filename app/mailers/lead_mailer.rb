class LeadMailer < ApplicationMailer
    def confirmation_mail
        @customer = params[:customer]
        mail(to: @customer.email, subject: 'Request Received')
    end
end