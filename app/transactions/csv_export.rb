require 'csv'
class CsvExport < Transaction
  step :validate
  tee :generate_csv_file
  tee :send_email
  tee :test
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

  def generate_csv_file(_input)
    csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
    @file       = Tempfile.new('contributors.csv', 'tmp')
    filepath    = @file.path
    CSV.open(filepath, 'wb', csv_options) do |csv|
      csv << %w[Name Created_at]
      @hash.each do |user|
        csv << [user.first_name, user.created_at]
      end
    end
  end

  def send_email(input)
    PostMailer.new_csv(
      'no-reply@capsens',
      input[:user],
      File.read(@file.path)
    ).deliver_later
  end

  def test
    byebug
  end
end
