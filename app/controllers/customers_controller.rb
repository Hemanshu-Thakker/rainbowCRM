class CustomersController < ApplicationController
    def index
        @customers = Customer.last(10)
    end

    def new
        @customer = Customer.new
    end

    def edit
        @customer = Customer.find_by(id: params[:id])
    end

    def show
        @customer = Customer.find_by(id: params[:id])
    end

    def create
        @customer = Customer.new(customer_params)
        if @customer.save
            if params["customer"]["remote"] == "true"
                render json: @customer
            else
                redirect_to customers_path(id: @customer)
            end
        elsif params["customer"]["remote"] == true
            render json: {error: 'Record not saved!'}
        else
            render "new"
        end
    end

    def update
        @customer = Customer.find_by(id: params[:id])
        if @customer.update(customer_params)
            redirect_to customers_path(id: @customer)
        else
            render "edit"
        end
    end

    def destroy
        @customer = Customer.find_by(id: params[:id])
        @customer.destroy
        redirect_to '/admin_dashboard'
    end

    private
    def customer_params
        params.require(:customer).permit(:name, :company_name, :mobile, :email, :note)
    end
end
