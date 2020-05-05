require 'csv'
require_relative 'base_repo'
require_relative '../models/employee'

class EmployeeRepository < BaseRepository
  undef_method :add

  def all_delivery_guys
    all.select { |employee| employee.delivery_guy? }
  end

  def find_by_username(username)
    all.find { |employee| employee.username == username  }
  end

  private

  def save_csv
    CSV.open(@csv_file_path, "wb") do |csv|
      csv << %w[id username password role]
      @elements.each do |employee|
        csv << [employee.id, employee.username, employee.password, employee.password]
      end
    end
  end

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file_path, csv_options) do |row|
      row[:id] = row[:id].to_i
      @elements << Employee.new(row)
    end
    @next_id = @elements.last.id + 1 unless @elements.empty?
  end

end
