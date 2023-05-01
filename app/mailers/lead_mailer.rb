class LeadMailer < ApplicationMailer
    def confirmation_mail
        @customer = params[:customer]
        mail(to: email_address_with_name(@customer.email, @customer.name), subject: 'Request Received')
    end
end