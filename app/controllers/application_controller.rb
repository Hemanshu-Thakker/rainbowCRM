class ApplicationController < ActionController::Base
    before_action :require_login
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

    def work_index
    end

    def current_employee
        @current_employee ||= Employee.find_by(id: session[:employee_id]) if session[:employee_id]
    end

    private
    def last_month
        (Time.now - 1.month).strftime("%B %Y")
    end

    def require_login
        redirect_to '/login' unless current_employee.present?
    end
end
