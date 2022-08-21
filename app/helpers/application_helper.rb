module ApplicationHelper
    
    def employee_select(all=false)
        if all
            employee_list = Employee.all
        else
            employee_list = Employee.where.not(employee_type: "admin")
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
        [
            ['Just In','just_in']
        ]
    end
end
