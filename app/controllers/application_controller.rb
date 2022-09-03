class ApplicationController < ActionController::Base
    
    def dashboard
        @new_customers = Customer.last_month
        @orders = Lead.last_month
        @customers_count = Customer.all.count
    end

    def export
        @records = Lead.last_month
        
        respond_to do |format|
            format.csv { send_data @records.to_csv, filename: "leads-#{last_month.split(" ").join('-').downcase}.csv" }
        end
    end

    private
    def last_month
        (Time.now - 1.month).strftime("%B %Y")
    end
end
