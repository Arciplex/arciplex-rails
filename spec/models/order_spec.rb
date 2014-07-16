require 'spec_helper'

describe Order do

  let(:user) { create(:user) }
  let(:order) { create(:order) }

  before do
    user
    order
    user.orders << order
  end

  describe "states" do
    describe ":pending" do
      it "should be initial state" do
        expect(order).to be_pending
      end

      it "should change :pending to :opened" do
        order.received!
        expect(order).to be_opened
      end

      it "should change from :pending to :opened to :closed" do
        order.received!
        order.complete!
        expect(order).to be_closed
      end

    end

  end

end
