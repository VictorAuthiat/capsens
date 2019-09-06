class LandUploader < BaseUploader
  require 'image_processing/mini_magick'

  plugin :processing # allows hooking into promoting
  plugin :versions   # enable Shrine to handle a hash of files

  VALID_EXTENSIONS = %w(jpg jpeg pdf PNG JPG JPEG PDF)
  VALID_MIME_TYPES = %w(image/jpg image/jpeg image/png application/pdf)
  MAX_FILESIZE     = 2.megabytes

  Attacher.validate do
    validate_max_size MAX_FILESIZE
    validate_extension_inclusion(VALID_EXTENSIONS)
    validate_mime_type_inclusion(VALID_MIME_TYPES)
  end

  process(:store) do |io, context|
    io.download do |original|
      pipeline = ImageProcessing::MiniMagick.source(original)

      pipeline.resize_to_limit!(300, 140)
    end
  end

  def generate_location(io, context)
    record    = context[:record]
    record_id = record&.id || generate_random
    @basename = super

    "app/#{record_id}/land_pictures/#{generate_random}/#{@basename}"
  end
end
