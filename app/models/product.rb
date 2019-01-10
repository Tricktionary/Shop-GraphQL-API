class Product < ApplicationRecord
  validates :title, uniqueness: true
end
