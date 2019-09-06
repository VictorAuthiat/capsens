class Category < ApplicationRecord
  has_many :projects, dependent: :destroy
end
