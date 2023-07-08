class Customer < ApplicationRecord
    has_many :leads
    has_rich_text :note

    scope :last_month, lambda {
        previous_month_begin = (Time.now - 1.month).beginning_of_month
        previous_month_end = (Time.now - 1.month).end_of_month
        where('created_at BETWEEN ? and ?',previous_month_begin,previous_month_end)
    }

    def self.to_csv
		attributes = %w{id customer_info items}
		
		CSV.generate(headers: true) do |csv|
			csv << attributes
	
			all.find_each do |user|
			csv << attributes.map{ |attr| user.send(attr) }
			end
		end
	end

    def customer_info
		master_string = ""
        master_string += "#{name} |" if name.present?
        master_string += "#{company_name} |" if company_name.present?
        master_string += "#{mobile} |" if mobile.present?
        master_string += "#{email}" if email.present?
        master_string
	end

    def items
        Lead.where(customer_id: id).pluck(:item_type).compact.map{|arr| JSON.parse(arr).reject(&:blank?)}.flatten.uniq.join(",")
    end

    def self.merge_customers_logic(customer_ids)
        primary_customer = Customer.find_by(id: customer_ids.first)
        secondary_customer_ids = customer_ids - [primary_customer.id.to_s]
        ActiveRecord::Base.transaction do
            secondary_customer_ids.each do |customer_id|
                customer = Customer.find_by(id: customer_id)
                customer_leads = customer.leads rescue []
                customer_leads.each do |lead|
                    lead.update(customer_id: primary_customer.id)
                end
                additional_info = primary_customer.note.to_s + "\nMerged #{customer.id} - #{customer.customer_info}"
                result = primary_customer.update(note: additional_info)
                customer.destroy!
            end
        end
    end
end