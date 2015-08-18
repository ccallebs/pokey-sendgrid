require 'pokey/hook'
require 'faker'

module Pokey
  module Sendgrid
    # Reference: https://sendgrid.com/docs/API_Reference/Webhooks/event.html
    class Hook < Pokey::Hook
      include Pokey::Sendgrid::MockData

      attr_accessor :category

      def destination
        "/api/sendgrid/events"
      end

      def data
        data = base_data

        case data["event"]
        # Delivery events
        when "bounce", "deferred", "delivered", "dropped", "processed"
          data.merge!({
            "smtp-id" => smtp_id
          })
        # Engagement events
        when "click", "open", "spamreport", "unsubscribe"
          data.merge!({
            "useragent" => user_agents.sample,
            "ip" => Faker::Internet.ip_v4_address
          })
        end

        data.merge!(unique_args)
        data
      end

      def categories
        []
      end

      def unique_args
        {}
      end

      protected

      def base_data
        {
          "timestamp" => Time.now.to_i,
          "category" => categories,
          "event" => sendgrid_events.sample,
          "email" => Faker::Internet.email
        }
      end

      def sendgrid_events
        [
          "processed",
          "dropped",
          "delivered",
          "deferred",
          "bounce",
          "open",
          "click",
          "spam_report",
          "unsubscribe",
          "group_unsubscribe",
          "group_resubscribe"
        ]
      end
    end
  end
end
