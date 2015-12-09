module PlaceHelper
  def get_content_for
    Place.where("page like ? or page like ?", "%#{params[:controller]}:#{params[:action]}\n%", "%All%")
  end
end
