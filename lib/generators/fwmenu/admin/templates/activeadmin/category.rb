ActiveAdmin.register Category do
	permit_params :title, :description, :slug, :layout
end
