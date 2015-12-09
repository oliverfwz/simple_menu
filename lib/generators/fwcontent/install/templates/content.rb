class <%= class_name %> < ActiveRecord::Base
  extend Enumerize

  validates :title, :description, presence: true

  serialize :page

  def page_enum
    (Rails.application.routes.routes.map(&:defaults).reject!(&:blank?).inject([]){|b, a| b << "#{a[:controller]}:#{a[:action]}" } << "All").compact.uniq.delete_if{ |i| i.include? "admin" or i.include? "rails" }.sort
  end
end