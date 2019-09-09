ActiveAdmin.register Project do
  permit_params :name, :content, :short_content, :image, :purpose, :category_id

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

  form do |f|
    f.inputs do
      f.input :name
      f.input :content
      f.input :image, as: :file
      f.input :purpose
      f.input :category
    end
    f.actions
  end
  show do
    contribution = project.contributions.map(&:amount_in_cents)
    contributions_sum = contribution.sum
    percentage = (contributions_sum * 100).fdiv(project.purpose)
    first = contribution.min
    last = contribution.max
    div do
      h4 'Current contributions: ' + contributions_sum.fdiv(100).to_s + ' $'
      h4 'percentage of completeness: ' + percentage.round.to_s + '%'
      h4 'Lower: ' + first.to_s
      h4 'Higher: ' + last.to_s
    end
    panel '' do
      attributes_table_for resource do
        row :name
        row :short_content
        row :image do |project|
          image_tag project.image[:medium].url
        end
        row :purpose
        row :created_at
      end
    end
    h1 'Contributions:'
    table_for project.contributions do
      column(:user)
      column(:amount_in_cents).pluck(&:amount_in_cents)
      column(:counterpart)
      column 'Created at', :created_at
    end
    h1 'Counterparts:'
    table_for project.counterparts do |counterpart|
      column(:name).map(&:name)
      column(:amount_in_cents).map(&:amount_in_cents)
      column(:stock).map(&:stock)
      column do |counterpart|
        link_to 'Edit', edit_admin_counterpart_path(counterpart.id)
      end
      column do |counterpart|
        link_to 'delete', admin_counterpart_path(counterpart.id), method: :delete, data: {confirm: 'Are you sure?'}
      end
      column do |counterpart|
        link_to 'new', new_admin_counterpart_path
      end
    end
  end
end
