class LandingEmailInput < SimpleForm::Inputs::Base
  def input(wrapper_options)
    template.content_tag(:div, class: 'input-group') do
      template.concat @builder.text_field(attribute_name, input_html_options)
      template.concat span_sign_up
    end
  end

  def input_html_options
    super.merge({class: 'form-control input-lg'})
  end

  def span_sign_up
    template.content_tag(:span, class: 'input-group-btn') do
      template.concat '<input type="submit" name="commit" value="Sign Up" class="btn btn-default btn btn-lg btn-success">'.html_safe

    end
  end

end