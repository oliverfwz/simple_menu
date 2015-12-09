class MenuItem < ActiveRecord::Base
  extend Enumerize

  validates :title, :menu, presence: true

  scope :level_ove, -> { where(level: 1) }

  belongs_to :menu
  belongs_to :parent, class_name: "MenuItem", foreign_key: "menu_item_id"
  has_many   :children, class_name: "MenuItem"

  before_save :set_level
  before_validation :validation_custom
  after_save :update_sort_tree

  def set_level
    self.level = self.parent.present? ? self.parent.level + 1 : 1
  end

  def array_menu_items_by_menu_item(items)
    arr = {}
    if items.present?
      items.each do |i|
        if i.parent.present?
          if arr[i.parent.id].nil?
            arr[i.parent.id] = [i]
          else
            arr[i.parent.id] << i
          end
        end
      end
    end
    arr
  end

  def get_child(item, arr)
    items = []
    if arr[item.id].present?
      arr[item.id].each do |i|
        items << i
        items = items + get_child(i, arr) if arr[i.id].present?
      end
    end
    items
  end

  def validation_custom
    arr = self.menu.present? ? array_menu_items_by_menu_item(menu.menu_items) : {}

    if internal_link
      errors.add(:page, "Please fill up this field")    unless page.present?
      errors.add(:show, "Please fill up this field")    if page.present? && show.nil? && page.include?(":id")
    else
      errors.add(:link, "Please fill up this field") unless link.present?
    end

    errors.add(:menu_item, "Please select parent belong to menu group") if parent.present? && menu.present? && menu.id != parent.menu.id
    errors.add(:menu_item, "Please don't select parent is submenu of this item or itself") if parent.present? && (get_child(self, arr).map(&:id).include?(menu_item_id) || id == menu_item_id)
    errors.add(:menu, "Please can not change menu group.") if menu_id.present? && menu_id_was.present? && parent.present? && menu_id != menu_id_was
  end

  def update_sort_tree
    update_columns(sort_tree: parent_ids_format_sort_tree([format_sort_tree(id)], self).reverse.join('.'))
  end

  def parent_ids_format_sort_tree(arr, menu_item)
    return arr if menu_item.menu_item_id.nil?
    arr.push(format_sort_tree(menu_item.menu_item_id))
    parent_ids_format_sort_tree(arr, menu_item.parent)
  end

  def format_sort_tree(number)
    return if number.nil?
    str = number.to_s
    "0000"[0..3 - str.length] + str
  end

  def child_ids(arr = [id])
    return [] if id.nil?

    ids = children.ids
    return arr if ids.nil?

    arr = arr + ids
    children.each do |item|
      arr = item.child_ids(arr)
    end
    arr 
  end

  def get_parents 
    MenuItem.includes(:menu).where.not(id: child_ids).map { |i| 
                                                            i.get_link_parents
                                                          }.sort
  end

  def get_link_parents
    a = [title, id]
    parent = self
    while parent.parent.present? do
      a[0] = "#{parent.parent.title} / #{a[0]}"
      parent = parent.parent
    end
    a[0] = "#{parent.menu.title} / #{a[0]}" if parent.menu.present?
    a
  end
end