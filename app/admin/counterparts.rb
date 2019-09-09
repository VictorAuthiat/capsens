ActiveAdmin.register Counterpart do
  permit_params :project_id, :name, :amount_in_cents
  form do |f|
    f.object.project_id = params[:project]
    h4 "Project: #{Project.find(object.project_id).name.capitalize}"
    f.inputs do
      f.input :project_id, as: :hidden
      f.input :name
      f.input :amount_in_cents
    end
    f.actions
  end
  show do |counterpart|
    panel '' do
      attributes_table_for resource do
        row :name
        row :amount_in_cents
        row 'project', Project.find(counterpart.project_id).name.capitalize
      end
    end
  end
end
