class LandUploader < Shrine
  require 'image_processing/mini_magick'

  plugin :validation_helpers
  plugin :processing # allows hooking into promoting
  plugin :versions   # enable Shrine to handle a hash of files

  VALID_EXTENSIONS = %w(jpg jpeg pdf PNG JPG JPEG PDF)
  MAX_FILESIZE     = 2.megabytes

  Attacher.validate do
    validate_max_size MAX_FILESIZE
    validate_extension_inclusion(VALID_EXTENSIONS)
  end

  process(:store) do |io, context|
    versions = { original: io } # retain original

    io.download do |original|
      pipeline = ImageProcessing::MiniMagick.source(original)

      versions[:large]  = pipeline.resize_to_limit!(800, 800)
      versions[:medium] = pipeline.resize_to_limit!(500, 500)
      versions[:small]  = pipeline.resize_to_limit!(300, 300)
    end

    versions # return the hash of processed files
  end
end
