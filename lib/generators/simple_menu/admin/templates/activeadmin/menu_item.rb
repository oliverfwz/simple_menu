ActiveAdmin.register MenuItem do
  permit_params :title, :link, :show, :page, :level, :internal_link, :menu_id, :menu_item_id, :ordering, :target, :published

  config.sort_order = "sort_tree_asc"

  index do
    column :id
    actions
    column :title, sorting: "title" do |menu_item|
      a = menu_item.title
      parent = menu_item
      while parent.parent.present? do
        a[0] = "--#{a[0]}"
        parent = parent.parent
      end
      a
    end
    column "External Link", :link
    column :page
    column :show
    column :internal_link
    column "Parent", :menu_item, :sortable => 'menu_items_menu_items.title'
    column "Menu", :menu, :sortable => 'menus.title'
    column :ordering
    column :published
  end

  controller do
    def scoped_collection
      end_of_association_chain.includes(:menu, :parent)
    end
  end

  form do |f|
    f.inputs 'Create News' do
      f.input :menu
      f.input :title
      f.input :link, label: "External Link"
      f.input :page, as: :select, collection: Rails.application.routes.routes.collect {|r| r.path.spec.to_s.gsub("(.:format)", "") }.compact.uniq.delete_if{|i|i.include? "admin" or i.include? "rails" }.sort
      f.input :show, label: "Id (Only for other components)"
      f.input :internal_link
      f.input :parent, label: "Parent", as: :select, collection: f.object.get_parents
      f.input :ordering
      f.input :published
      f.input :target, as: :select, collection: ["_self","_blank","_parent","_top"], include_blank: false
    end
    actions
  end
end
