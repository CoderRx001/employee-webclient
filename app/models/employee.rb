class Employee
  attr_accessor :id, :first_name, :last_name, :email, :birthday
  def initialize(hash_options)
    @id = hash_options["id"]
    @first_name = hash_options["first_name"]
    @last_name = hash_options["last_name"]
    @email = hash_options["email"]
    @birthday = Date.parse(hash_options["birthday"]) if hash_options["birthday"]
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def friendly_birthday
    birthday ? birthday.strftime('%b %d, %Y') : "N/A"
  end

  def self.find(id)
    Employee.new(
                Unirest.get("#{ ENV["API_HOST"] }/api/v2/employees/#{ id }.json").body)
                headers: {
                          "Accept" => "application/json",
                          "X-User-Email" => "joe@gmail.com",
                          "Authorization" => "Token token=infonomnom"
                          }
                .body)
  end

  def self.all
    employees = []
    Unirest.get(
                "#{ ENV["API_HOST"] }/api/v2/employees/#{ id }.json",

                ).body)
      employees << Employee.new(employee_hash)
    end
    employees
  end

  def self.create(employees_params)
    response = Unirest.post(
      "#{ ENV["API_HOST"] }/api/v2/employees.json?first_name=#{params[:first_name]}&last_name=#{[:last_name]}&email=#{[:email]}",
                            headers: {
                                      "Accept" => "application/json"
                                      },
                            parameters: employee_params
                              ).body
    Employee.new(response)
  end

  # def update(employee_params)
  #   response = Unirest.patch(
  #                           )
    
  # end

  def destroy
    Unirest.delete(
                   "#{ ENV["API_HOST"] }/api/v1/employees/#{params["id"]}.json",
                   headers: {"Accept" => "application/json"}
                   ).body
  end
end

