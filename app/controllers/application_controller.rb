class ApplicationController < ActionController::Base
    
    def dashboard
        @new_customers = Customer.last_month
        @orders = Lead.last_month
        @customers_count = Customer.all.count
    end
end
