class Article < ActiveRecord::Base
	extend Enumerize
	extend FriendlyId
  validates :title, :description, presence: true

  validates :slug, uniqueness: true
  
  belongs_to :category
  
  friendly_id :title, use: [:slugged, :finders]

  before_save :set_slug

  enumerize :layout, in: Dir.glob('app/views/articles/show/*').collect{|r| r.gsub("app/views/", "").split('.').first}

  def set_slug
  	self.slug = title.parameterize if slug.blank? && title.present?
  end
end