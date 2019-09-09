ActiveAdmin.register Counterpart do
  permit_params :project_id, :name, :amount_in_cents
  form do |f|
    h4 "Project: #{Project.find(params[:project]).name.capitalize}"
    f.inputs do
      f.input :project_id, input_html: { value: params[:project] }, as: :hidden
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
        row :project
      end
    end
  end
end
