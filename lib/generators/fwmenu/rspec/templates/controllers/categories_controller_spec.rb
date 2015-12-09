require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  describe '#show' do
  	let!(:category)        { create(:category) }
    let!(:articles)        { create_list(:article, 3, category_id: category.id) }
   
    it 'assigns a category page' do
      get :show, id: category.id
      expect(assigns(:category).id).to eq category.id
      expect(assigns(:category).articles.size).to eq category.articles.size
    end
  end
end