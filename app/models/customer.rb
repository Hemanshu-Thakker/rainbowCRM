class Customer < ApplicationRecord
    has_many :leads
    has_rich_text :note
end