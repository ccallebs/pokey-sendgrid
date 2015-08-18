module Pokey
  module Sendgrid
    module MockData
      def user_agents
        [
          "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_4) AppleWebKit/600.7.12 (KHTML, like Gecko) Version/8.0.7 Safari/600.7.12",
          "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:39.0) Gecko/20100101 Firefox/39.0",
          "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.134 Safari/537.36",
          "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:39.0) Gecko/20100101 Firefox/39.0",
          "Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; rv:11.0) like Gecko"
        ]
      end

      def smtp_id
        prefix = Faker::Internet.password(10, 20)
        suffix = Faker::Internet.password(10, 20)
        domain = Faker::Internet.domain_word
        "#{prefix}_#{suffix}@#{domain}.mail"
      end
    end
  end
end
