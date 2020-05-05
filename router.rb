class Router
  def initialize(meals_controller, customers_controller, sessions_controller, orders_controller)
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @sessions_controller = sessions_controller
    @orders_controller = orders_controller
    @running = true
  end

  def run
    @employee = @sessions_controller.sign_in
    case @employee.role
    when 'manager'
      while @running
        print_manager_menu
        choice = gets.chomp.to_i
        print `clear`
        manager_route_action(choice)
      end
    when 'delivery_guy'
      while @running
        print_delivery_guy_menu
        choice = gets.chomp.to_i
        print `clear`
        delivery_guy_route_action(choice)
      end
    end
  end

  private

  def print_manager_menu
    puts "--------------------"
    puts "------- MENU -------"
    puts "--------------------"
    puts "1. Add new meal"
    puts "2. List all meals"
    puts "3. Add new customer"
    puts "4. List all customers"
    puts "5. List undelivered orders"
    puts "6. Create an Order"
    puts "8. Exit"
    print "> "
  end

  def print_delivery_guy_menu
    puts "--------------------"
    puts "------- MENU -------"
    puts "--------------------"
    puts "1. See my undelivered orders"
    puts "2. Mark an order as delivered"
    puts "8. Exit"
    print "> "
  end

  def manager_route_action(choice)
    case choice
    when 1 then @meals_controller.add
    when 2 then @meals_controller.list
    when 3 then @customers_controller.add
    when 4 then @customers_controller.list
    when 5 then @orders_controller.list_undelivered
    when 6 then @orders_controller.create
    when 8 then stop!
    else
      puts "Try again..."
    end
  end

  def delivery_guy_route_action(choice)
    case choice
    when 1 then @orders_controller.list_my_undelivered(@employee)
    when 2 then @orders_controller.mark_as_delivered(@employee)
    when 8 then stop!
    else
      puts "Try again..."
    end
  end

  def stop!
    @running = false
  end
end
