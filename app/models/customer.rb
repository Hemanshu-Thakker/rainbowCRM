class Customer < ApplicationRecord
    has_many :leads
    has_rich_text :note

    scope :last_month, lambda {
        previous_month_begin = (Time.now - 1.month).beginning_of_month
        previous_month_end = (Time.now - 1.month).end_of_month
        where('created_at BETWEEN ? and ?',previous_month_begin,previous_month_end)
    }
end