class Position < ActiveRecord::Base
  validates :title, presence: true
end