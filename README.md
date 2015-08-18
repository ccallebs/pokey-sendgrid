# Pokey::Sendgrid

Sensible defaults to emulate Sendgrid data on development/QA using Pokey hooks.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pokey-sendgrid'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pokey-sendgrid

## Usage

If this is your first installation (and you're on Rails), run

`$ rails g pokey:install`

This will create an initializer file that defines your `hook_dir` (the
location where all hooks will be defined). Just create a new file in that
directory that inherits from `Pokey::Sendgrid::Hook`.

Simple example:

``` RUBY
class SendgridHook < Pokey::Sendgrid::Hook
  # Your Sendgrid webhook endpoint
  def destination
    # Defaults to /api/sendgrid/events
    "http://localhost:3000/api/sendgrid/events"
  end

  # Time (in seconds) between Pokey requests
  def interval
    5 # Defaults to 5
  end
end
```

#### Categories and Unique Arguments
This gem also supports dynamic categories / unique arguments when generating
data. To use:

``` RUBY
class SendgridHook < Pokey::SendgridHook
  def categories
    [
      ["User", "Welcome Email"],
      ["Billing", "Payment Successful"]
    ]
  end

  def unique_args
    {
      "custom-identifier" => 15
    }
  end
end
```

#### Limiting Events
By default, Pokey::Sendgrid will generate all types of SendGrid events:
- processed
- dropped
- delivered
- deferred
- bounce
- open
- click
- spam_report
- unsubscribe
- group_unsubscribe
- group_resubscribe

To limit the amount of events your application receives, override the
`sendgrid_events` method like so:

``` RUBY
class SendgridHook < Pokey::SendgridHook
  protected

  # Limits events to only "Open" and "Click"
  def sendgrid_events
    ["open", "click"]
  end
end
```

#### Start generating data
If you're on rails, just start your server. Otherwise, start your application.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/pokey-sendgrid. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

