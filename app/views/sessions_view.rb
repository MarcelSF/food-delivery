class SessionsView
  def ask_for(label)
    puts "Please insert #{label}"
    gets.chomp
  end

  def try_again
    puts "Wrong credentials, try again"
  end

  def success
    puts "You are signed in!"
  end
end
