require 'spec_helper'
require 'pokey'

describe Pokey::Sendgrid::Hook do
  subject { Pokey::Sendgrid::Hook.new }

  it "defaults to sensible destination endpoint" do
    expect(subject.destination).to eq "http://localhost:3000/api/sendgrid/events"
  end

  describe "#data" do
    it "includes base data" do
      expect(subject.data["timestamp"]).not_to be_nil
      expect(subject.data["event"]).not_to be_nil
      expect(subject.data["email"]).not_to be_nil
    end

    context "when Delivery event" do
      before do
        allow(subject).to receive(:sendgrid_events).and_return ["delivered"]
      end

      it "includes delivery data" do
        expect(subject.data["smtp-id"]).not_to be_nil
      end
    end

    context "when Engagement event" do
      before do
        allow(subject).to receive(:sendgrid_events).and_return ["click"]
      end

      it "includes engagement data" do
        expect(subject.data["useragent"]).not_to be_nil
        expect(subject.data["ip"]).not_to be_nil
      end
    end
  end

  context "when subclassed" do
    let(:derived_hook) { 
      class DerivedHook < Pokey::Sendgrid::Hook
      end

      DerivedHook.new
    }

    it "has populated data" do
      expect(subject.interval).not_to be_nil
      expect(subject.destination).not_to be_nil
      expect(subject.http_method).not_to be_nil
      expect(subject.data["timestamp"]).not_to be_nil
      expect(subject.data["event"]).not_to be_nil
      expect(subject.data["email"]).not_to be_nil
    end

    it "is able to make request" do
      allow(Pokey::Request).to receive(:make!).and_return true
      expect { subject.make_http_request! }.not_to raise_error
    end
  end
end
