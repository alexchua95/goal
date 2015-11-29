class DurationInput < SimpleForm::Inputs::Base
  def input(wrapper_options)
    template.content_tag(:div, class: 'input-group') do
      template.concat @builder.text_field(attribute_name, input_html_options)
      template.concat span_hours
    end
  end

  def input_html_options
    super.merge({class: 'form-control input-lg'})
  end

  def span_hours
    template.content_tag(:span, class: 'input-group-addon') do
      template.concat 'hours'
    end
  end

end