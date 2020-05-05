require "csv"
require_relative "../models/meal"
require_relative 'base_repo'

class MealRepository < BaseRepository

  private

  def save_csv
    CSV.open(@csv_file_path, "wb") do |csv|
      csv << %w[id name price]
      @elements.each do |meal|
        csv << [meal.id, meal.name, meal.price]
      end
    end
  end

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file_path, csv_options) do |row|
      row[:id] = row[:id].to_i
      row[:price] = row[:price].to_i
      @elements << Meal.new(row)
    end
    @next_id = @elements.last.id + 1 unless @elements.empty?
  end
end
