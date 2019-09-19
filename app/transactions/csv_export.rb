require 'csv'
class CsvExport < Transaction
  step :validate
  step :generate_csv_file

  private

  def validate(input)
    @project = Project.find(input[:pro].to_i)
    @hash = @project.contributors
    if @hash.empty?
      Failure(input.merge(error: 'This project has no contributors'))
    else
      Success(input)
    end
  end

  def generate_csv_file(input)
    csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
    file       = Tempfile.new('contributors.csv', 'tmp')
    filepath   = file.path
    CSV.open(filepath, 'wb', csv_options) do |csv|
      csv << %w[Name Created_at]
      @hash.each do |user|
        csv << [user.first_name, user.created_at]
      end
    end
    Success(input.merge(file: file))
  end
end
