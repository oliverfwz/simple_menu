class Menu < ActiveRecord::Base
  extend Enumerize
  validates :title, :position, presence: true

  has_many :menu_items
end