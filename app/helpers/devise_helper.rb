module DeviseHelper
  def devise_error_messages!
    messages = resource.errors.full_messages

    flash.now[:error] = Array.wrap(flash.now[:error]) + messages unless messages.empty?

    nil
  end
end
