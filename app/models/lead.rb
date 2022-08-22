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
		completed: 6
	}

	def self.item_type_list 
		[
			"visiting_card",
			"poster",
			"website_development",
			"design",
			"catalogue",
			"envelope",
			"letterpad",
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
			"others"
		]
	end
end