ActiveAdmin.register <%= file_name.camelize %> do
	permit_params :title, :description, :position, :published

	form do |f|
    f.inputs 'Create News' do
      f.input :title
      f.input :description
      f.input :position, as: :select, collection: Position.all.map(&:title), include_blank: false
      # f.input :published
    end
    actions
  end
end
