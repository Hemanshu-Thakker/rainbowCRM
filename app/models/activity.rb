class Activity < ApplicationRecord
    belongs_to :lead

    def self.create_new(description,lead_id)
        self.create(description: description, lead_id: lead_id)
    end
end