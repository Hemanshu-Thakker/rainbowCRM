module SessionsHelper
	def log_in user
	    session[:employee_id] = user.id
	end

	def log_out
		session.delete(:employee_id)
    	@current_employee = nil
	end
end
