WickedPdf.config = {}

if Rails.env.development?
  WickedPdf.config[:lowquality] = true
end
