class CustomersController < ApplicationController
    def index
        @customer = nil
    end

    def fetch_customer
        @customer = Customer.find_by(id: params[:customer_id])
        
        respond_to do |format|
            format.html
        end
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
        @customer.destroy if @current_employee.email == "hemanshu@rainbow.com"
        # Do some toast message implementation here
        redirect_to '/customers/index'
    end

    def export_customer_order_data
        @records = Customer.all
        
        respond_to do |format|
            format.csv { send_data @records.to_csv, filename: "customer-data-new.csv" }
        end
    end

    def merge_customers
        valid_customers = merge_params["customers"].reject(&:blank?)
        Customer.merge_customers_logic(valid_customers)
        redirect_to '/customers/index'
    end

    private
    def customer_params
        params.require(:customer).permit(:name, :company_name, :mobile, :email, :note)
    end

    def merge_params
        params.permit(:customers => [])
    end
end
