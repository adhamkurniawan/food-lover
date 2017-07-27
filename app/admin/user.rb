ActiveAdmin.register User do
  permit_params :first_name, :last_name, :email, :password

  index do
    id_column
    column :first_name
    column :last_name
    column :email
  end

  show do
    attributes_table do
      row :id
      row :first_name
      row :last_name
      row :email
    end
  end

  form do |f|
    f.inputs do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :password
    end
  end
end
