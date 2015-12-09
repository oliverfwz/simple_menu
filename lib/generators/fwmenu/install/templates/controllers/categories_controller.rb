class CategoriesController < ApplicationController
	def show
		@category = Category.includes(:articles).find(category_id)
		render @category.layout if @category.layout.present?
	end

	def category_id
		params.require(:id)
	end
end