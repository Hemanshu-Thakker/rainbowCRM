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
			"Standy"
			"others"
		]
	end

	def self.handle_index_filter(params)
		
	end

	def self.handle_index_search(params)
		
	end
end