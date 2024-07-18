ActiveAdmin.register StaticPage do
    permit_params :title, :content
  
    form do |f|
      f.inputs do
        f.input :title
        f.input :content, as: :quill_editor  # Assuming you want a rich text editor
      end
      f.actions
    end
  
    index do
      selectable_column
      id_column
      column :title
      column :content
      actions
    end
  
    show do
      attributes_table do
        row :title
        row :content do |page|
          raw page.content
        end
      end
    end
  end
  