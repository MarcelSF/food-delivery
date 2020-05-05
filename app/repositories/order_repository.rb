require_relative '../models/order'
require 'pry-byebug'
class OrderRepository
  def initialize(csv_path, meal_repo, customer_repo, employee_repo)
    @meal_repository = meal_repo
    @customer_repository = customer_repo
    @employee_repository = employee_repo
    @csv_path = csv_path
    @orders = []
    if File.exist?(@csv_path)
      load_csv
      @next_id = @orders.empty? ? 1 : @orders.last.id + 1
    end
  end

  def undelivered_orders
    @orders.select { |order| order.delivered? == false }
  end

  def my_undelivered(employee)
    @orders.select { |order| order.employee.id == employee.id && !order.delivered? }
  end

  def add(order)
    @next_id = 1 if @next_id.nil?
    order.id = @next_id
    @orders << order
    @next_id += 1
    save_csv
  end

  private

  def save_csv
    CSV.open(@csv_path, "wb") do |csv|
      csv << %w[id delivered meal_id employee_id customer_id]
      @orders.each do |order|
        csv << [order.id, order.delivered?, order.meal.id, order.employee.id, order.customer.id]
      end
    end
  end

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_path, csv_options) do |row|
      @orders << Order.new(
        id: row[:id].to_i,
        meal: @meal_repository.find(row[:meal_id].to_i),
        employee: @employee_repository.find(row[:employee_id].to_i),
        customer: @customer_repository.find(row[:customer_id].to_i),
        delivered: row[:delivered] == 'true'
      )
    end
  end
end
