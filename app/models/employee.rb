class Employee < ApplicationRecord
    has_many :leads
    has_secure_password

    enum employee_type: {
		admin: 0,
		manager: 1,
		designer: 2,
		developer: 3,
		finisher: 4,
		computer: 5
	}

	scope :soul, -> { where.not(employee_type: "computer") }
	scope :not_admin , -> { where.not(employee_type: "admin") }
end