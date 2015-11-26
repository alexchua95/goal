class TimePickerInput < SimpleForm::Inputs::Base
  def input(wrapper_options)
    template.content_tag(:div, { class: 'input-group date form_time' }.reverse_merge!(options)) do
      template.concat @builder.text_field(attribute_name, input_html_options)
      template.concat span_calendar
    end
  end

  def input_html_options
    super.merge({class: 'form-control'})
  end

  def span_calendar
    template.content_tag(:span, class: 'input-group-addon') do
      template.concat icon_calendar
    end
  end

  def icon_calendar
    '<span class="glyphicon glyphicon-calendar"></span>'.html_safe
  end

end