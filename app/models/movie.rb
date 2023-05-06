class Movie < ApplicationRecord
  validates :title, presence: true
  validates :descriptiom, presence: true
end
