class Employee < ApplicationRecord
    has_many :leads
    has_secure_password

    enum employee_type: {
		admin: 0,
		manager: 1,
		designer: 2,
		developer: 3,
		finisher: 4
	}
end