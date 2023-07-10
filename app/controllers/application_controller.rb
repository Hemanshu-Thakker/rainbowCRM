class ApplicationController < ActionController::Base
    before_action :require_login
    def dashboard
        @months_for_statistics = Hash.new
        month_pointer = start_month
        while month_pointer.to_date < Date.today
            @months_for_statistics[month_pointer] = Hash.new
            @months_for_statistics[month_pointer]["new_customers"] = Customer.for_month(month_pointer).count
            @months_for_statistics[month_pointer]["new_orders"] = Lead.for_month(month_pointer).count
            month_pointer = next_month month_pointer
        end
        @customers_count = Customer.all.count
    end

    def export
        if params[:month].present?
            @records = Lead.for_month(params[:month])
        else
            @records = Lead.last_month
        end
        
        respond_to do |format|
            format.csv { send_data @records.to_csv, filename: "leads-#{params[:month].split(" ").join('-').downcase}.csv" }
        end
    end

    def export_customer_data
        @records = Lead.all
        
        respond_to do |format|
            format.csv { send_data @records.to_csv, filename: "customer-data.csv" }
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

    def start_month
        Date.parse('march, 2022').strftime("%B %Y")
    end

    def next_month(current_month)
        Date.parse(current_month).next_month.strftime("%B %Y")
    end

    def require_login
        redirect_to '/login' unless current_employee.present?
    end
end
