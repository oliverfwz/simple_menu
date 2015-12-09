class Category < ActiveRecord::Base
	extend Enumerize
	extend FriendlyId
	has_many :articles

	friendly_id :title, use: [:slugged, :finders]

	validates :title, :description, presence: true

	validates :slug, uniqueness: true

	enumerize :layout, in: Dir.glob('app/views/categories/show/*').collect{|r| r.gsub("app/views/", "").split('.').first}

	before_save :set_slug
	
	def set_slug
  	self.slug = title.parameterize if slug.blank? && title.present?
  end
end