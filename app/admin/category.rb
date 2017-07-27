ActiveAdmin.register Category do
  permit_params :name

  index do
    id_column
    column :name
  end

  show do
    attributes_table do
      row :id
      row :name
    end
  end

  form do |f|
    f.inputs do
      f.input :name
    end
    f.actions
  end
end