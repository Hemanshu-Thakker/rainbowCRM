class SessionsController < ApplicationController
	skip_before_action :require_login, only: [:new, :create]
	include SessionsHelper

	def new
  	end

  	def create
  		user = Employee.find_by(email: params[:email])
  		if user && user.authenticate(params[:password])
	      	log_in user
	      	redirect_to root_path
	    else
	      	flash.now[:danger] = 'Invalid email/password combination'
	      	render 'new'
	    end
  	end

  	def destroy
  		log_out
  		redirect_to '/login'
  	end
end