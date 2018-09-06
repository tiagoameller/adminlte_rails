module FlashMessagesHelper
  def flash_messages(options = { dimissable: true })
    flash.each do |msg_type, message|
      bootstrap_class = bootstrap_class_for msg_type
      concat(content_tag(
        :div, message,
        class: "alert #{bootstrap_class} #{(options[:dimissable] == true ? 'alert-dimissable' : '')} fade show",
        role: 'alert'
      ) do
        if options[:dimissable] == true
          concat(content_tag(:button, class: 'close', data: { dismiss: 'alert' }, 'aria-label' => 'Close') do
            concat(content_tag(:span, '&times;'.html_safe, 'aria-hidden' => true))
          end)
        end
        concat(content_tag(:h5) do
          if bootstrap_class == 'alert-success'
            concat content_tag(:span, '<i class="fa fa-check"></i>'.html_safe, 'aria-hidden' => true)
          elsif bootstrap_class == 'alert-danger'
            concat content_tag(:span, '<i class="fa fa-ban"></i>'.html_safe, 'aria-hidden' => true)
          elsif bootstrap_class == 'alert-warning'
            concat content_tag(:span, '<i class="fa fa-exclamation-triangle"></i>'.html_safe, 'aria-hidden' => true)
          else
            concat content_tag(:span, '<i class="fa fa-info"></i>'.html_safe, 'aria-hidden' => true)
          end.concat ' ' + bootstrap_class # TODO: localize
        end)
        concat message
      end)
    end
    nil
  end

  private

  def bootstrap_class_for(flash_type)
    { success: 'alert-success', error: 'alert-danger', alert: 'alert-warning', notice: 'alert-info' }[flash_type.to_sym] || flash_type.to_s
  end
end
