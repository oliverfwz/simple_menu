class ArticlesController < ApplicationController
	def show
		@article = Article.find(article_id)
		render @article.layout if @article.layout.present?
	end

	def article_id
		params.require(:id)
	end
end