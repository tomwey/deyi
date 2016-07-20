ActiveAdmin.register AppType do

  menu priority: 10
  
  permit_params :name, :parent_id, :icon, :sort, :opened
  
  index do
    selectable_column
    column 'ID', :id
    column '分类图标', sortable: false do |type|
      if type.icon.blank?
        ''
      else
        image_tag type.icon.url(:thumb)
      end
    end
    column :name, sortable: false
    column '父级分类', sortable: false do |type|
      type.parent.try(:name) || '一级分类'
    end
    column :sort
    column :opened, sortable: false
    column :created_at
    actions
  end

  form do |f|
    f.inputs do 
      f.input :name
      f.input :parent_id, as: :select, collection: AppType.preferred_types_for(f.object.try(:id)), hint: '建议分类层次不要太深', include_blank: false
      f.input :icon, as: :file, hint: '支持jpg,jpeg,png,gif'
      f.input :sort, hint: '值越小越靠前'
      f.input :opened, hint: '是否使用该类别'
    end
    actions
  end


end
