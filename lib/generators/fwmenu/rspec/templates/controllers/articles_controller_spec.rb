require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  describe '#show' do
    let!(:article)        { create(:article) }
   
    it 'assigns a article page' do
      get :show, id: article.id
      expect(assigns(:article).id).to eq article.id
    end
  end
end