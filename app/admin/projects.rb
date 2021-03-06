ActiveAdmin.register Project do
  permit_params(
    :name,
    :content,
    :short_content,
    :image,
    :purpose,
    :category_id,
    counterparts_attributes: %i[amount_in_cents name]
  )

  action_item :check_state, only: :show do
    link_to 'update state', url_for(action: :check_state)
  end
  member_action :check_state do
    transaction = ProjectCheck.new.call(project: resource)
    redirect_to admin_project_path(resource)
    if transaction.success?
      aasm = resource.aasm_state
      flash[:success] = "The state successfully has changed to: #{aasm}"
    else
      flash[:error] = "The state can not change: #{resource.aasm_state}"
    end
  end

  action_item :project_succeeded, only: :show do
    aasm = resource.aasm_state
    link_to 'SUCCESS', url_for(action: :project_succeeded) if aasm == 'ongoing'
  end
  member_action :project_succeeded do
    transaction = ProjectSucceeded.new.call(project: resource)
    redirect_to admin_project_path(resource)
    if transaction.success?
      flash[:success] = "Your project is a: #{resource.aasm_state}"
    else
      flash[:error] = 'Failure'
    end
  end
  action_item :new_counterpart, only: :show, if: proc { resource.aasm_state != 'ongoing' } do
    link_to 'new counterpart', new_admin_counterpart_path(project: project.id)
  end
  index do
    id_column
    column :name
    column :purpose
    column :created_at

    actions
  end

  filter :name
  filter :created_at
  filter :purpose
  filter :aasm_state, as: :select, collection: Project.state

  form do |f|
    f.inputs do
      f.input :name
      f.input :content
      f.input :short_content
      f.input :image, as: :file
      f.input :purpose
      f.input :category
      if f.object.new_record?
        f.has_many :counterparts, new_record: true, allow_destroy: false do |c|
          c.inputs do
            c.input :amount_in_cents, input_html: { value: 0 }
            c.input :name, as: :string, input_html: { value: '1 Counterpart' }
          end
        end
      end
    end
    f.actions
  end
  show do
    first = project.contributions.minimum(:amount_in_cents)
    last = project.contributions.maximum(:amount_in_cents)
    sum = project.contributions.sum(:amount_in_cents).fdiv(100).to_s
    div do
      h4 'Current contributions: ' + sum + ' $'
      h4 'Percentage of completeness: ' + project.percentage.round.to_s + '%'
      h3 'Contributions:'
      h4 'Lower: ' + first.fdiv(100).to_s + '€' if first
      h4 'Higher: ' + last.fdiv(100).to_s + '€' if last
    end
    panel '' do
      attributes_table_for resource do
        row :name
        row :short_content
        row :image do
          image_tag(resource.image[:medium].url) if resource.image[:medium].url
        end
        row :purpose
        row 'state' do
          project.aasm_state
        end
        row :created_at
      end
    end
    h1 'Contributions:'
    table_for project.contributions do
      column(:user)
      column(:amount_in_cents)
      column(:counterpart)
      column 'Created at', :created_at
      column(:aasm_state)
    end
    h1 'Counterparts:'
    table_for project.counterparts do
      column(:name).pluck(:name)
      column(:amount_in_cents).pluck(:amount_in_cents)
      column(:stock).pluck(:stock)
      column do |counterpart|
        link_to edit_admin_counterpart_path(counterpart.id, project: project) do
          'Edit'
        end
      end
      column do |counterpart|
        link_to 'Delete', admin_counterpart_path(counterpart.id, project: project.id), method: :delete, data: { confirm: 'Are you sure?' }
      end
    end
  end
  action_item :preview, only: :show do
    link_to 'preview', project_path(resource)
  end
end
