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
		"#{name}|#{company_name}|#{mobile}|#{email}"
	end

    def items
        Lead.where(customer_id: id).pluck(:item_type).compact.map{|arr| JSON.parse(arr).reject(&:blank?)}.flatten.uniq.join(",")
    end
end