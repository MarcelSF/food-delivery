require "csv"
require_relative "../models/customer"
require_relative "base_repo"

class CustomerRepository < BaseRepository

  private

  def save_csv
    CSV.open(@csv_file_path, "wb") do |csv|
      csv << [:id, :name, :address]
      @elements.each do |elt|
        csv << [elt.id, elt.name, elt.address]
      end
    end
  end

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file_path, csv_options) do |row|
      row[:id] = row[:id].to_i
      @elements << Customer.new(row)
    end
  end
end
