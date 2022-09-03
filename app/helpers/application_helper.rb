module ApplicationHelper
    
    def employee_select(all=false)
        if all
            employee_list = Employee.soul
        else
            employee_list = Employee.soul.not_admin
        end
        result = []
        employee_list.each do |employee|
            result << [employee.name, employee.id]
        end
        result
    end
    
    def item_select_options
        items_list = Lead.item_type_list
        result = []
        items_list.each do |item,index|
            new_item = capitalize(item)
            result << [new_item, new_item]
        end
        result
    end

    def item_select_value(lead)
        JSON.parse lead.item_type rescue []
    end

    def item_type_csv(lead)
        result_arr = JSON.parse lead.item_type rescue []
        result_arr.reject { |a| a.empty? }.join(", ")
    end

    def customer_select
        customers_list = Customer.all
        result = []
        customers_list.each do |customer|
            result << [displayName(customer),customer.id]
        end
        result
    end

    def displayName(customer)
        if customer.name.present? and customer.company_name.present?
            customer.name + " - " + customer.company_name
        elsif customer.name.present?
            customer.name
        else
            customer.company_name
        end
    end

    def get_creater(id)
        Employee.find_by(id: id).name rescue 'Error_occured'
    end

    def capitalize(item)
        begin
            item = item.dup
            item[0] = item[0].capitalize
            item.split("_").join(" ")
        rescue
            "Error_occured"
        end
    end

    def new_customer
        Customer.new
    end

    def status_select_just_in
        result = []
        lead_statuses = Lead.statuses
        lead_statuses.each do |k,v|
            result << [capitalize(k),k] unless k == "completed"
        end
        result
    end

    def status_background(lead)
        if (Date.today - lead.created_at.to_date).to_i >= 2
            if lead.employee.name == "Nancy"
                'status-bg-default'
            else
                'status-bg-red'
            end
        else
            'status-bg-default'
        end
    end

    def standard_datetime(date)
        date.in_time_zone("Chennai").strftime("%d %b, %l:%M %p")
    end

    def status_options
        result = []
        Lead.statuses.each do |k,v|
            result << [capitalize(k),k] if k != "completed"
        end
        result
    end

    def current_status(lead)
        lead.status
    end

    def build_params(data,url_params)
        params = filter_params_to_hash(url_params)
        if data.present?
            arr = data.split(":")
            params["filter"][arr[0]] = arr[1]
        end
        params
    end

    def remove_params(data,url_params)
        params = filter_params_to_hash(url_params)
        if data.present?
            params["filter"].delete(data)
        end
        params
    end

    def filter_params_to_hash(url_data)
        url_data["filter"] == nil ? {"filter" => {}} : {"filter" => url_data["filter"]}
    end

    def htmlIZE(str)
        "<div>"+str+"</div>"
    end

    def last_month
        (Time.now - 1.month).strftime("%B %Y")
    end

    def active?(url_params,data)
        params = filter_params_to_hash(url_params)
        orange = params["filter"]["filter_by_status"].present? rescue false
        matcher = params["filter"]["filter_by_status"] == data if orange
        orange and matcher ? "bg-orange" : "" 
    end

    def item_pie_chart
        result = {}
        items_list = Lead.item_type_list
        items_list.each do |li|
            result[capitalize(li)] = Lead.where('item_type ILIKE ?',"%#{capitalize(li)}%").count
        end
        result.reject { |k,v| v == 0 }.sort_by { |k,v| v }.last(10).to_h
    end
end
