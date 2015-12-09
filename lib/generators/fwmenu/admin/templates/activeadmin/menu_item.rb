ActiveAdmin.register <%= file_name.camelize %>Item do
	permit_params :title, :link, :show, :page, :level, :internal_link, :<%= file_name %>_id, :<%= file_name %>_item_id, :article_id, :category_id, :ordering, :target, :published

  index do
    actions
    column :title, sorting: "title" do |<%= file_name %>_item|
      a = <%= file_name %>_item.title
      parent = <%= file_name %>_item
      while parent.<%= file_name %>_item.present? do
        a[0] = "---- #{a[0]}"
        parent = parent.<%= file_name %>_item
      end
      a
    end
    column "External Link", :link
    column :page
    column :show
    column :article
    column :category
    column :internal_link
    column "Parent", :<%= file_name %>_item, :sortable => '<%= file_name %>_items_<%= file_name %>_items.title'
    column "<%= file_name.camelize %>", :<%= file_name %>, :sortable => '<%= file_name %>s.title'
    column :ordering
    column :published
  end

  controller do
    def scoped_collection
      end_of_association_chain.includes(:<%= file_name %>, :<%= file_name %>_item)
    end
  end

	form do |f|
    f.inputs 'Create News' do
    	f.input :<%= file_name %>
      f.input :title
      f.input :link, label: "External Link"
      f.input :page, as: :select, collection: Rails.application.routes.routes.collect {|r| r.path.spec.to_s.gsub("(.:format)", "") }.compact.uniq.delete_if{|i|i.include? "admin" or i.include? "rails" }.sort
      f.input :show, label: "Id (Only for other components)"
      f.input :article, label: "Articles (Only for article page)"
      f.input :category, label: "Categories (Only for category page)"
      f.input :internal_link
      f.input :<%= file_name %>_item, label: "Parent", as: :select, collection: <%= file_name.camelize %>Item.includes(:<%= file_name %>_item, :<%= file_name %>).all.map { |i| 
                                                                                                              a = [i.title, i.id]
                                                                                                              parent = i
                                                                                                              while parent.<%= file_name %>_item.present? do
                                                                                                                a[0] = "#{parent.<%= file_name %>_item.title} / #{a[0]}"
                                                                                                                parent = parent.<%= file_name %>_item
                                                                                                              end
                                                                                                              a[0] = "#{parent.<%= file_name %>.title} / #{a[0]}" if parent.<%= file_name %>.present?
                                                                                                              a
                                                                                                            }.sort
      f.input :ordering
      f.input :published
      f.input :target, as: :select, collection: ["_self","_blank","_parent","_top"], include_blank: false
    end
    actions
  end
end
