class BaseRepository
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @elements = []
    if File.exist?(@csv_file_path)
      load_csv
      @next_id = @elements.empty? ? 1 : @elements.last.id + 1
    end
  end

  def all
    @elements
  end

  def add(element)
    @next_id = 1 if @next_id.nil?
    element.id = @next_id
    @elements << element # doesn't have an ID
    # Increment @next_id!
    @next_id += 1
    save_csv
  end

  def find(id) # Int
    @elements.find { |elt| elt.id == id }
  end
end
