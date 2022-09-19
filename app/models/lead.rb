require 'csv'

class Lead < ApplicationRecord
    belongs_to :customer
	belongs_to :employee
	has_rich_text :description

    enum status: {
		just_in: 0,
        designing: 1,
		printing: 2,
		development: 3,
		binding: 4,
		post_press: 5,
		ready_for_delivery: 6,
		payment_pending: 7,
		completed: 8
	}

	scope :soul_less, -> { joins(:employee).where('employees.name ILIKE ?','LEAD MASTER') }

	scope :last_month, lambda {
        previous_month_begin = (Time.now - 1.month).beginning_of_month
        previous_month_end = (Time.now - 1.month).end_of_month
        where('created_at BETWEEN ? and ?',previous_month_begin,previous_month_end)
    }

	def self.item_type_list 
		[
			"visiting_card",
			"poster",
			"webs_design_&_development",
			"digital_marketing",
			"design",
			"catalogue",
			"envelope",
			"letterpad",
			"letterhead",
			"bill_book",
			"brochure",
			"id_card",
			"sticker",
			"binding",
			"banner/flex",
			"standee",
			"vinyl_stickers",
			"receipt_books",
			"certificate",
			"admission_form",
			"label",
			"pamphlet",
			"invitation",
			"diary",
			"box",
			"notepads",
			"tag",
			"folder",
			"invoice_book",
			"file",
			"inserts",
			"leaflet",
			"hardcase_books",
			"softcover_books",
			"annual_report",
			"calendar",
			"Inlay cards",
			"Booklet souvenir",
			"magazine",
			"Examination card",
			"office stationery",
			"Coupon",
			"bag",
			"Standy",
			"Slip pad",
			"Order form",
			"register",
			"books",
			"ticket",
			"others"
		]
	end

	def self.to_csv
		attributes = %w{id created_date customer_info items quantity paper_type colour size s_no slip_no payment_details info price}
		
		CSV.generate(headers: true) do |csv|
			csv << attributes
	
			all.find_each do |user|
			csv << attributes.map{ |attr| user.send(attr) }
			end
		end
	end

	def created_date
        "#{created_at.in_time_zone("Chennai").strftime("%d %b, %l:%M %p")}"
    end

	def info
		"#{description.to_plain_text}"
	end

	def customer_info
		"#{customer.name} #{customer.company_name} #{customer.mobile} #{customer.email}"
	end

	def items
		JSON.parse(item_type).reject(&:blank?).join(",") rescue ""
	end
end