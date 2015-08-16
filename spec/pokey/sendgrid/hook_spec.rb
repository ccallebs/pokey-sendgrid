require 'spec_helper'

describe Pokey::Sendgrid::Hook do
  subject { Pokey::Sendgrid::Hook.new }

  it "defaults to sensible destination endpoint" do
    expect(subject.destination).to eq "/api/sendgrid/events"
  end
end
