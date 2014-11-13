module Notifications
  module Notifier
    extend self

    attr_accessor :factory

    def publish(action, initiator, resource, options = {})
      recipients = (Array.wrap(options[:for] || resource.watchers) - [initiator]).uniq
      notifications = []

      recipients.each do |recipient|
        notifications << factory.create!(action: action, initiator: initiator, recipient: recipient, resource: resource, anonymous: !!options[:anonymous])
      end

      notifications
    end

    def factory
      @factory ||= Notification
    end
  end
end
