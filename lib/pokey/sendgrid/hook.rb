require 'pokey/hook'

module Pokey
  module Sendgrid
    # Reference: https://sendgrid.com/docs/API_Reference/Webhooks/event.html
    class Hook < Pokey::Hook
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
            "smtp-id" => "placehoder.unil@faker.local"
          })
        # Engagement events
        when "click", "open", "spamreport", "unsubscribe"
          data.merge!({
            "email" => "placeholder@until-faker.com",
            "useragent" => "Placeholder/5.0 (Until faker)",
            "ip" => "127.0.0.1"
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
          "email" => "placeholder@until-faker.com"
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
