require_relative '../views/orders_view'
require_relative '../views/meals_view'
require_relative '../views/customers_view'

class OrdersController
  def initialize(order_repository, meal_repository, customer_repository, employee_repository)
    @order_repository = order_repository
    @customer_repository = customer_repository
    @meal_repository = meal_repository
    @employee_repository = employee_repository
    @view = OrdersView.new
  end

  def create
    MealsView.new.display(@meal_repository.all)
    meal_id = @view.ask_for_index("meal number").to_i

    @view.list_delivery_guys(@employee_repository.all_delivery_guys)
    employee_index = @view.ask_for_index("delivery guy").to_i

    CustomersView.new.display(@customer_repository.all)
    customer_index = @view.ask_for_index("customer").to_i

    meal = @meal_repository.find(meal_id)
    employee = @employee_repository.find(employee_index)
    customer = @customer_repository.find(customer_index)
    @order_repository.add(Order.new(meal: meal, employee: employee, customer: customer, delivered: false))
  end

  def list_undelivered
    undelivered = @order_repository.undelivered_orders
    @view.list_undelivered(undelivered)
  end

  def list_my_undelivered(employee)
    my_undelivered = @order_repository.my_undelivered(employee)
    @view.list_undelivered(my_undelivered)
  end
end
