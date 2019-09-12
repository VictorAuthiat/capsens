ActiveAdmin.register Counterpart do
  permit_params :project_id, :name, :amount_in_cents
  controller do
    def destroy
      destroy! { admin_project_path(params[:proj]) }
    end
  end
  form do |f|
    p = Project.all.map { |u| ["#{u.name}, goal:#{u.purpose}€", u.id] }
    if params[:proj]
      h4 "Project: #{Project.find(params[:proj]).name.capitalize}"
    end
    f.inputs do
      if params[:proj]
        f.input :project_id, input_html: { value: params[:proj] }, as: :hidden
      else
        f.input :project_id, label: 'Project', as: :select, collection: p
      end
      f.input :name
      f.input :amount_in_cents
    end
    f.actions
  end
  show do
    panel '' do
      attributes_table_for resource do
        row :name
        row :amount_in_cents
        row :project
      end
    end
  end
end
