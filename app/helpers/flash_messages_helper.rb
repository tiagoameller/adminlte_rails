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
            concat fa_icon('check')
          elsif bootstrap_class == 'alert-danger'
            concat fa_icon('ban')
          elsif bootstrap_class == 'alert-warning'
            concat fa_icon('exclamation-triangle')
          else
            concat fa_icon('info')
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
