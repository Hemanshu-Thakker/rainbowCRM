class Lead < ApplicationRecord
    belongs_to :customer
    
    enum item_type: {
		visiting_card: 0,
		poster: 1,
		website_development: 2,
		design: 3,
		catalogue: 4,
		envelope: 5,
		letterpad: 6,
		bill_book: 7,
		brochure: 8,
		id_card: 9,
		sticker: 10
	}

    enum status: {
		just_in: 0,
        designing: 1,
		printing: 2,
		development: 3,
		binding: 4,
		post_press: 5
	}
end