module ApplicationHelper
  def display_base_errors resource
    return '' if (resource.errors.empty?) or (resource.errors[:base].empty?)
    messages = resource.errors[:base].map { |msg| content_tag(:p, msg) }.join
    html = <<-HTML
    <div class="alert alert-error alert-block">
      <button type="button" class="close" data-dismiss="alert">&#215;</button>
      #{messages}
    </div>
    HTML
    html.html_safe
  end

  def data_tables
    render 'utils/data_tables'
  end

  def file_input
    render 'utils/file_input'
  end

  def page_head
    render 'layouts/page_head'
  end

  def attach
    @attach = Uploader.new
  end

  def folder
    @folder = Folder.new
  end

  def folders
    @folders = Folder.all
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def page_entries_info(collection, name)
    content_tag :ul, :class => "pagination pagination-header" do
      content_tag :li do
        content_tag :span, :class => "first" do
            collection_name = name
            if collection.count > 0
              "Mostrando #{collection.offset_value + 1} - #{collection.offset_value + collection.length} de #{collection.klass.count} #{collection_name.capitalize }"
            end
        end
      end
    end
  end

end
