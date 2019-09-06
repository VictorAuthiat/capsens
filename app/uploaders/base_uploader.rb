class BaseUploader < Shrine
  def generate_random
    SecureRandom.hex(20)
  end
end
