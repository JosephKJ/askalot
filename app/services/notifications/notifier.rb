module Notifications
  module Notifier
    extend self

    attr_accessor :factory

    def publish(action, initiator, resource, options = {})
      recipients = Array.wrap(options[:for] || resource.watchers) - [initiator]

      recipients.each do |recipient|
        factory.create!(action: action, initiator: initiator, recipient: recipient, notifiable: resource)
      end
    end

    def factory
      @factory ||= Notification
    end
  end
end