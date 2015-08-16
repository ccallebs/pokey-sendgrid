require 'pokey/hook'

module Pokey
  module Sendgrid
    class Hook < Pokey::Hook
      attr_accessor :category

      def destination
        "/api/sendgrid/events"
      end

      def data
        data = base_data

        case data["event"]
        when "click", "open", "spamreport", "unsubscribe"
          data.merge({
            "email": "placeholder@unit-faker.com",
            "useragent": "Placeholder/5.0 (Until faker)",
            "ip": "127.0.0.1"
          })
        end
      end

      protected

      def base_data
        {
          "timestamp": Time.zone.now.in_seconds,
          "category": category,
          "event": sendgrid_events.sample,
          "smtp-id": "placeholder.until@faker.local"
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
