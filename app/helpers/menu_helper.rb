module MenuHelper
  def get_link(item)
    if item.internal_link && item.page.present?
      if item.page.to_s == "/articles/:id" && item.article.present?
        link_to item.title, Rails.application.routes.url_helpers.article_path(item.article), target: item.target
      elsif item.page.to_s == "/categories/:id" && item.category.present?
        link_to item.title, Rails.application.routes.url_helpers.category_path(item.category), target: item.target
      elsif item.page.include? ":id"
        link = item.page.gsub(":id", item.show.to_s)
        link_to item.title, link, target: item.target
      else
        link_to item.title, item.page, target: item.target
      end
    else
      link_to item.title, item.link, target: item.target
    end
  end
end