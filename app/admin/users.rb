ActiveAdmin.register User do
  permit_params :name, :email, :password,  :role_id, :status

  index do
    selectable_column
    id_column
    column :name
    column :email
    column :role
    column :status
    actions
  end

  filter :name
  filter :email
  filter :role
  filter :status

  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :role, include_blank: false
       f.input :status, as: :select, collection: User.statuses.keys.map { |status| [status.to_s.humanize, status] }, include_blank: false
    end
    f.actions
  end
end