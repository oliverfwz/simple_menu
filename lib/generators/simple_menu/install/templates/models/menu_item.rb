class MenuItem < ActiveRecord::Base
  extend Enumerize

  validates :title, :menu, presence: true

  scope :level_ove, -> { where(level: 1) }

  belongs_to :menu
  belongs_to :parent, class_name: "MenuItem", foreign_key: "menu_item_id"
  has_many   :children, class_name: "MenuItem"
end