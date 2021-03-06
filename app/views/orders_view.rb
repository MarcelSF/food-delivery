class OrdersView
  def list_undelivered(orders)
    orders.each_with_index do |order, index|
      puts "#{index + 1} - #{order.employee.username}: #{order.customer.name} - #{order.meal.name}"
    end
  end

  def ask_for_index(label)
    puts "Please insert index of #{label}"
    gets.chomp
  end

  def list_delivery_guys(guys)
    guys.each_with_index do |guy, index|
      puts "#{index} - #{guy.username}"
    end
  end
end
