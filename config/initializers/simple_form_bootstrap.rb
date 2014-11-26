# # Use this setup block to configure all options available in SimpleForm.
# SimpleForm.setup do |config|
#   config.wrappers :bootstrap, :tag => 'div', :class => 'form-group', :error_class => 'error' do |b|
#     b.use :html5
#     b.use :placeholder
#     b.use :label
#     b.wrapper :tag => 'div', :class => 'col-lg-10' do |ba|
#       ba.use :input
#       ba.use :error, :wrap_with => { :tag => 'span', :class => 'help-inline' }
#       ba.use :hint,  :wrap_with => { :tag => 'p', :class => 'help-block' }
#     end
#   end
#
#   config.wrappers :prepend, :tag => 'div', :class => "form-group", :error_class => 'error' do |b|
#     b.use :html5
#     b.use :placeholder
#     b.use :label
#     b.wrapper :tag => 'div', :class => 'col-lg-10' do |input|
#       input.wrapper :tag => 'div', :class => 'input-prepend' do |prepend|
#         prepend.use :input
#       end
#       input.use :hint,  :wrap_with => { :tag => 'span', :class => 'help-block' }
#       input.use :error, :wrap_with => { :tag => 'span', :class => 'help-inline' }
#     end
#   end
#
#   config.wrappers :append, :tag => 'div', :class => "form-group", :error_class => 'error' do |b|
#     b.use :html5
#     b.use :placeholder
#     b.use :label
#     b.wrapper :tag => 'div', :class => 'col-lg-10' do |input|
#       input.wrapper :tag => 'div', :class => 'input-append' do |append|
#         append.use :input
#       end
#       input.use :hint,  :wrap_with => { :tag => 'span', :class => 'help-block' }
#       input.use :error, :wrap_with => { :tag => 'span', :class => 'help-inline' }
#     end
#   end
#
#   # Wrappers for forms and inputs using the Twitter Bootstrap toolkit.
#   # Check the Bootstrap docs (http://twitter.github.com/bootstrap)
#   # to learn about the different styles for forms and inputs,
#   # buttons and other elements.
#   config.default_wrapper = :bootstrap
# end
# http://stackoverflow.com/questions/14972253/simpleform-default-input-class
# https://github.com/plataformatec/simple_form/issues/316

inputs = %w[
  CollectionSelectInput
  DateTimeInput
  FileInput
  GroupedCollectionSelectInput
  NumericInput
  PasswordInput
  RangeInput
  StringInput
  TextInput
]

inputs.each do |input_type|
  superclass = "SimpleForm::Inputs::#{input_type}".constantize

  new_class = Class.new(superclass) do
    def input_html_classes
      super.push('form-control')
    end
  end

  Object.const_set(input_type, new_class)
end

# Use this setup block to configure all options available in SimpleForm.
SimpleForm.setup do |config|
  config.boolean_style = :nested

  config.wrappers :bootstrap3, tag: 'div', class: 'form-group', error_class: 'danger',
                  defaults: { input_html: { class: 'default_class' } } do |b|

    b.use :html5
    b.use :min_max
    b.use :maxlength
    b.use :placeholder

    b.optional :pattern
    b.optional :readonly

    b.use :label_input
    b.use :hint,  wrap_with: { tag: 'span', class: 'help-block alert-info' }
    b.use :error, wrap_with: { tag: 'span', class: 'alert-warning' }
  end

  config.wrappers :bootstrap3_horizontal, tag: 'div', class: 'form-group', error_class: 'alert-info' do |b|

    b.use :html5
    b.use :min_max
    b.use :maxlength
    b.use :placeholder

    b.optional :pattern
    b.optional :readonly

    b.use :label
    b.wrapper :right_column, tag: :div do |component|
      component.use :input
    end
    b.use :hint,  wrap_with: { tag: 'span', class: 'help-block alert-info' }
    b.use :error, wrap_with: { tag: 'span', class: 'alert-warning' }
  end

  config.wrappers :group, tag: 'div', class: "form-group", error_class: 'danger',
                  defaults: { input_html: { class: 'default-class '} }  do |b|

    b.use :html5
    b.use :min_max
    b.use :maxlength
    b.use :placeholder

    b.optional :pattern
    b.optional :readonly

    b.use :label
    b.use :input, wrap_with: { class: "input-group" }
    b.use :hint,  wrap_with: { tag: 'span', class: 'help-block alert-info' }
    b.use :error, wrap_with: { tag: 'span', class: 'alert-warning' }
  end

  config.default_wrapper = :bootstrap3
end
