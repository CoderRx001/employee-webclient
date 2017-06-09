class EmployeesController < ApplicationController

  def index
    # @employees = Unirest.get("#{ ENV["API_HOST"] }/api/v2/employees.json").body
    @employees = []

    Unirest.get("#{ ENV["API_HOST"] }/api/v2/employees.json").body.each do |employee_hash|
      @employees << Employee.new(employee_hash)
    end
  end

  def new
    
  end

  def create

    employee = Employee.create(
                                first_name: params[:first_name],
                                last_name: params[:last_name],
                                email: params[:email],
                              ).body

    redirect_to "/employees/#{employee.id}"
  end

  def show
    @employee = Employee.find(params[:id])
  end

  def edit
    @employee = Employee.find(params[:id])
  end

  def update
    @employee = Employee.find(params[:id])

    @employee.update(
                    first_name: params[:first_name],
                    last_name: params[:last_name],
                    email: params[:email]                    
                   )
    employee = Unirest.patch(
                            "#{ ENV["API_HOST"] }/api/v2/employees/#{params["id"]}.json",
                            headers: {
                                      "Accept" => "application/json"
                                      },
                            parameters: {
                                     first_name: params[:first_name],
                                     last_name: params[:last_name],
                                     email: params[:email]
                                    }
                            ).body

    redirect_to "/employees/#{employee["id"]}"
  end

  def destroy
    employee = Employee.find(params[:id])
    employee.destroy
    redirect_to "/employees"
  end
end
