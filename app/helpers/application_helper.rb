module ApplicationHelper
    
    def employee_select
        employee_list = Employee.all
        result = []
        employee_list.each do |employee|
            result << [employee.name, employee.id]
        end
        result
    end
    
    def item_select
        items_list = Lead.item_types.keys
        result = []
        items_list.each do |item|
            new_item = capitalize(item)
            result << [new_item, item]
        end
        result
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

    def capitalize(item)
        item = item.dup
        item[0] = item[0].capitalize
        item.split("_").join(" ")
    end
end
