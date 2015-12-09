class <%= file_name.camelize %>Item < ActiveRecord::Base
	extend Enumerize

	validates :title, :<%= file_name %>, presence: true

	belongs_to :<%= file_name %>
	belongs_to :<%= file_name %>_item
	has_many 	 :<%= file_name %>_items
	belongs_to :article
	belongs_to :category

	before_save :set_level
	before_validation :validation_custom
	after_save :save_<%= file_name %>s_to_module

	def save_<%= file_name %>s_to_module
		save_<%= file_name %>_to_module(<%= file_name %>) if <%= file_name %>.present?
		save_<%= file_name %>_to_module(<%= file_name.camelize %>.find(<%= file_name %>_id_was)) if <%= file_name %>_id_was.present?
		true
	end

	def save_<%= file_name %>_to_module(single_menu)
		items = {"items" => [single_menu]}
		html = render_anywhere("<%= file_name %>", items)
		html = "<ul></ul>" if html.empty?
		mod_<%= file_name %>s = Place.where(position: single_menu.position)
		if mod_<%= file_name %>s.size == 1
			mod_<%= file_name %>s.first.update(description: html)
		else		
			mod_<%= file_name %> = Place.new(title: single_menu.title, description: html, page: "All", position: single_menu.position)
			mod_<%= file_name %>.save
		end
	end

	def render_anywhere(partial, assigns = {}) 
		view = ActionView::Base.new(ActionController::Base.view_paths, assigns)
		view.extend ApplicationHelper
		view.extend <%= file_name.camelize %>Helper
		view.render(:partial => partial)
	end

	def set_level
		self.level = self.<%= file_name %>_item.present? ? self.<%= file_name %>_item.level + 1 : 1
	end

	def array_<%= file_name %>_items_by_<%= file_name %>_item(items)
		arr = {}
		if items.present?
			items.each do |i|
				if i.<%= file_name %>_item.present?
					if arr[i.<%= file_name %>_item.id].nil?
						arr[i.<%= file_name %>_item.id] = [i]
					else
						arr[i.<%= file_name %>_item.id] << i
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
		arr = self.<%= file_name %>.present? ? array_<%= file_name %>_items_by_<%= file_name %>_item(self.<%= file_name %>.<%= file_name %>_items.includes(:<%= file_name %>_item)) : {}

		if internal_link
			errors.add(:page, "Please fill up this field") 		unless page.present?
			errors.add(:article, "Please fill up this field") if page.to_s == "/articles/:id" && article.nil?
			errors.add(:category, "Please fill up this field") if page.to_s == "/categories/:id" && category.nil?
			errors.add(:show, "Please fill up this field") 		if page.present? && page.to_s != "/categories/:id" && page.to_s != "/articles/:id" && show.nil? && page.include?(":id")
		else
			errors.add(:link, "Please fill up this field") unless link.present?
		end

		errors.add(:<%= file_name %>_item, "Please select parent belong to <%= file_name %> group") if <%= file_name %>_item.present? && <%= file_name %>.present? && <%= file_name %>.id != <%= file_name %>_item.<%= file_name %>.id
		errors.add(:<%= file_name %>_item, "Please don't select parent is sub<%= file_name %> of this item or itself") if <%= file_name %>_item.present? && (get_child(self, arr).map(&:id).include?(<%= file_name %>_item_id) || id == <%= file_name %>_item_id)
		errors.add(:<%= file_name %>, "Please can not change <%= file_name %> group.") if <%= file_name %>_id.present? && <%= file_name %>_id_was.present? && <%= file_name %>_item.present? && <%= file_name %>_id != <%= file_name %>_id_was
	end
end