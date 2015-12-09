ActiveAdmin.register <%= class_name %> do
  permit_params :title, :description, :position, page:[]

  form do |f|
    f.inputs 'Create News' do
      f.input :title
      f.input :description
      f.input :position, as: :select, collection: Position.all.map(&:title)
      f.input :page, as: :select, collection: (Rails.application.routes.routes.map(&:defaults).reject!(&:blank?).inject([]){ |b, a| b << "#{a[:controller]}:#{a[:action]}" } << "All").compact.uniq.delete_if{ |i| i.include? "admin" or i.include? "rails" }.sort, multiple: :multiple
    end
    actions
  end
end