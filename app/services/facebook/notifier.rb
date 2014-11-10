facebook = module Facebook
  module Notifier
    include QuestionsHelper
    include TextHelper

    include ActivitiesHelper
    include NotificationsHelper

    include ActionView::Helpers::TextHelper
    include ActionView::Helpers::TranslationHelper

    include ERB::Util

    extend self

    def publish(action, initiator, resource, options = {})
      recipients = (Array.wrap(options[:for] || resource.watchers) - [initiator]).uniq

      if [Answer, Question, Comment].find { |type| resource.is_a? type }
        recipients.each do |recipient|

          if recipient.omniauth_token
            user = FbGraph::User.me(recipient.omniauth_token).fetch
            application = FbGraph::Application.new(Configuration.facebook.application.id, secret: Configuration.facebook.application.secret)

            user.notification!(
              access_token: application.get_access_token,
              href: Configuration.facebook.application.link,
              template: notification_content_by_attributes(action, initiator, resource, unlink: true)
            )
          end
        end
      end
    end
  end
end
