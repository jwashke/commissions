class ImportCsvJob < ActiveJob::Base
  queue_as :default

  def perform(file_path)
    CsvImporter.new(file_path).run
  end
end
