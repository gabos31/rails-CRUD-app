class CustomFormBuilder < ActionView::Helpers::FormBuilder
  include ActionView::Helpers::TagHelper
  attr_accessor :output_buffer

  def text_field(name, label_text, options = {})
    tag.div class: 'form-label-group' do
      super(name, options.reverse_merge(class: 'form-control', placeholder: label_text)) +
        label(name, label_text)
    end
  end
end
