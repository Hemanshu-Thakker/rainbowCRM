class LeadsController < ApplicationController
    def index
        @leads = Lead.order(updated_at: :desc).where.not(status: "completed")
        if params["filter"].present?
            begin
                employee_name = params["filter"]["assigned_to"] rescue false
                lead_status = params["filter"]["filter_by_status"] rescue false
                priority = params["filter"]["priority"] rescue false
                if employee_name.present?
                    employee = Employee.where('lower(name) = ?',employee_name).first
                    @leads = @leads.where(employee_id: employee.id)
                end
                if lead_status.present?
                    @leads = @leads.where(status: lead_status)
                end
                if priority.present?
                    @leads
                end
            rescue
            end
        end

        if params["query"].present?
            @leads = @leads.joins(:customer).where("customers.name ILIKE ? OR customers.company_name ILIKE ? OR item_type ILIKE ?","%#{params["query"]}%","%#{params["query"]}%","%#{params["query"]}%")
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
