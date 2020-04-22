class LawProject < ApplicationRecord
  validates :name, :description, :link, presence: true
end
