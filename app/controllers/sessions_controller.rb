require_relative '../views/sessions_view'

class SessionsController
  def initialize(employee_repository)
    @view = SessionsView.new
    @employee_repository = employee_repository
  end

  def sign_in
    username = @view.ask_for(:username)
    password = @view.ask_for(:password)
    employee = @employee_repository.find_by_username(username)
    if employee && employee.password == password
      @view.success
      return employee
    else
      @view.try_again
      sign_in
    end
  end
end
