class LeadsController < ApplicationController
    def index
        @leads = Lead.last(10)
    end

    def new
        @lead = Lead.new
    end

    def edit
        @lead = Lead.find_by(id: params[:id])
    end

    def show
        @lead = Lead.find_by(id: params[:id])
    end

    def create
        @lead = Lead.new(lead_params)
        if @lead.save
            redirect_to leads_path(id: @lead)
        else
            render "new"
        end
    end

    def update
        @lead = Lead.find_by(id: params[:id])
        if @lead.update(lead_params)
            redirect_to leads_path(id: @lead)
        else
            render "edit"
        end
    end

    def destroy
        binding.pry
        @lead = Lead.find_by(id: params[:id])
        @lead.destroy
        redirect_to root_path
    end

    private
    def lead_params
        params.require(:lead).permit(:customer_id, :employee_id, :item_type, :description, :quantity, :paper_type, :colour, :s_no, :slip_no, :payment_details)
    end
end
