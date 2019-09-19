require 'csv'
class CsvExport < Transaction
  tee :generate_csv_file
  tee :read_csv_file
  step :import

  private

  def generate_csv_file(input)
    @user = input[:user]
    @project = Project.find(input[:pro].to_i)
    arr_of_contributors = []
    hash = @project.contributions.group_by(&:user)
    hash.each { |k, _v| arr_of_contributors << k }
    csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
    @file       = Tempfile.new('contributors.csv', 'tmp')
    @filepath   = @file.path
    CSV.open(@filepath, 'wb', csv_options) do |csv|
      csv << %w[Name Created_at]
      arr_of_contributors.each do |user|
        arr = Array.new(2)
        arr[0] = user.first_name
        arr[1] = user.created_at
        csv << arr
      end
    end
  end

  def read_csv_file(_input)
    @users = []
    csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
    CSV.foreach(@filepath, csv_options) do |row|
      puts "#{row['Name']}, crée à #{row['Created_at']}"
      @users << row
    end
  end

  def import(input)
    if @users.empty?
      Failure(input.merge(error: 'This project has no contributors'))
    else
      Success(input.merge(filepath: @filepath))
    end
  end
end
