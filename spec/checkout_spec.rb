require 'checkout'

describe Checkout do 
    let(:checkout) { described_class.new() }

    it "scans an item" do
        checkout.scan({code: "001", name: "Very Cheap Chair", price: 9.25})
        expect(checkout.total).to eq 9.25
    end 
end 