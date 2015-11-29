class LocationInput < SimpleForm::Inputs::Base
  def input(wrapper_options)
    template.content_tag(:div, class: 'input-group') do
      template.concat span_location
      template.concat @builder.text_field(attribute_name, input_html_options)
    end
  end

  def input_html_options
    super.merge({class: 'form-control input-lg'})
  end

  def span_location
    template.content_tag(:span, class: 'input-group-addon') do
      template.concat '<span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span>'.html_safe
    end
  end

end