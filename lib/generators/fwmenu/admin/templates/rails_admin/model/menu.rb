class <%= class_name %> < ActiveRecord::Base
	extend Enumerize
	validates :title, :position, presence: true

	has_many :<%= file_name %>_items
	after_save :save_<%= file_name %>s_to_module

	def save_<%= file_name %>s_to_module
		save_<%= file_name %>_to_module(self) if self.present?
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

	rails_admin do
		edit do
			field :title
			field :description 
			field :position, :enum do
				enum do
    			Position.all.map(&:title)
  			end
			end
			# field :published
		end
	end
end