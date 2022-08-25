class LeadsController < ApplicationController
    def index
        @leads = Lead.order(updated_at: :desc).where.not(status: "completed")
        if params["filter"].present?
            begin
                employee_name = params["filter"]["assigned_to"] rescue false
                lead_status = params["filter"]["sort_by_status"] rescue false
                if employee_name
                    employee = Employee.find_by_name(employee_name)
                    @leads = @leads.where(employee_id: employee.id)
                elsif lead_status
                    @leads = @leads.where(status: lead_status)
                end
            rescue
            end
        end
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
        @lead = Lead.find_by(id: params[:id])
        @lead.destroy
        redirect_to root_path
    end

    def update_status_complete
        @lead = Lead.find_by(id: params[:id])
        if params[:status].present? and Lead.statuses.include?(params[:status])
            @lead.update(status: params[:status])
        end
        render json: {success: "Lead successfully updated"}
    end

    private
        def lead_params
            # params["lead"]["item_type"] = params["lead"]["item_type"].to_json
            params.require(:lead).permit(:customer_id, :employee_id, :created_by, :description, :quantity, :paper_type, :colour, :s_no, :slip_no, :size, :payment_details, :status, :item_type => [])
        end
end
