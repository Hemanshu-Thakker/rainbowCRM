class LeadsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:lead_generation]
    skip_before_action :require_login, only: [:lead_generation]

    def index
        piyush_logic_status = ((params["filter"] && params["filter"]["filter_by_status"].present?) || params["query"].present?) ? 
            ["completed"] : ["completed","payment_pending","ready_for_delivery"]
        @leads = Lead.order(created_at: :desc).where.not(status: piyush_logic_status)   
        if params["filter"].present?
            begin
                employee_name = params["filter"]["assigned_to"] rescue false
                lead_status = params["filter"]["filter_by_status"] rescue false
                priority = params["filter"]["priority"] rescue false
                filtered_date = params["filter"]["by_date"] rescue false
                if employee_name.present?
                    employee = (employee_name == "me") ? Employee.find_by(id: @current_employee.id) : Employee.where('lower(name) = ?',employee_name).first
                    @leads = @leads.where(employee_id: employee.id)
                end
                if lead_status.present?
                    @leads = @leads.where(status: lead_status)
                end
                if priority.present?
                    @leads
                end
                if filtered_date.present?
                    @leads = @leads.where(created_at: filtered_date.to_date.beginning_of_day..filtered_date.to_date.end_of_day)
                end
            rescue
            end
        end

        if params["query"].present?
            @leads = @leads.joins(:customer).where("customers.name ILIKE ? OR customers.company_name ILIKE ? OR item_type ILIKE ? OR CAST(leads.id as VARCHAR) ILIKE ?","%#{params["query"]}%","%#{params["query"]}%","%#{params["query"]}%","%#{params["query"]}")
            @leads = search_using_display_name(params["query"]) if params["query"].include?("RP")
        end
        computer_employee = Employee.find_by(employee_type: "computer").id
        @leads = @leads.where.not(employee_id: computer_employee)
        @leads_count = @leads.count
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

    def update_assigned_to
        @lead = Lead.find_by(id: params[:id]) rescue nil
        updated_assigned_to_id = params[:employee_id]
        @lead.update(employee_id: updated_assigned_to_id)
        redirect_to leads_path(id: @lead)
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
        if params[:status] == "completed"
            root_params = params[:root_params].to_unsafe_h.except(:action, :controller)
            redirect_to root_path(root_params)
        else
            render json: {success: "Lead successfully updated"}
        end
    end

    def lead_generation
        @customer = Customer.find_or_create_by(customer_api_params)
        if @customer.save
            @employee = Employee.find_by(employee_type: "computer", name: "Automation")
            @lead = Lead.new(customer_id: @customer.id, description: htmlIZE(params[:description]), employee_id: @employee.id, created_by: @employee.id, status: 'just_in')
            if @lead.save
                render json: {success: "Lead successfully created"}
            else
                render json: {error: "Lead creation issue"}
            end
        else
            render json: {error: "Customer creation issue"}
        end
    end

    def website_leads
        employee_id = Employee.find_by(employee_type: "computer").id
        @leads = Lead.order(created_at: :desc).where(employee_id: employee_id)
        @leads_count = @leads.count
        render 'index'
    end

    def find
        @leads = []
    end

    def find_filter
        customer_id = params[:customer_id]
        leads_display_number = params[:lead_id]
        search_term = params[:search]
        @leads = []
        if customer_id.present?
            selected_customer = Customer.find_by(id: customer_id)
            @leads = selected_customer.leads
        end
        if leads_display_number.present?
            @leads = search_using_display_name(leads_display_number) if leads_display_number.include?("RP")
            @leads = Lead.where(status: "completed").joins(:customer).where("customers.name ILIKE ? OR customers.company_name ILIKE ? OR item_type ILIKE ? OR CAST(leads.id as VARCHAR) ILIKE ?","%#{leads_display_number}%","%#{leads_display_number}%","%#{leads_display_number}%","%#{leads_display_number}") unless leads_display_number.include?("RP")
        end
        if search_term.present?
            @leads = Lead.where(status: "completed").joins(:customer).where("customers.name ILIKE ? OR customers.company_name ILIKE ? OR item_type ILIKE ? OR CAST(leads.id as VARCHAR) ILIKE ?","%#{search_term}%","%#{search_term}%","%#{search_term}%","%#{search_term}")
        end
        unless @leads.present?
            flash[:error] = "No records available"
        end
        flash[:error] = "No records available"
        render 'find'
    end

    private
        def htmlIZE(str)
            "<div>"+str+"</div>"
        end

        def customer_api_params
            params.permit(:description)
            params.permit(:name,:mobile,:email)
        end

        def lead_params
            params.require(:lead).permit(:customer_id, :employee_id, :created_by, :description, :quantity, :paper_type, :colour, :s_no, :slip_no, :size, :payment_details, :status, :item_type => [])
        end

        def search_using_display_name(str)
            id = str[2..-1].to_i
            Lead.where(id: id)
        end
end
