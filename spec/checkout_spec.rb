require 'checkout'

describe Checkout do 
    let(:checkout) { described_class.new() }

    it "creates a total for multiple items" do
        checkout.scan({code: "001", name: "Very Cheap Chair", price: 9.25})
        checkout.scan({code: "002", name: "Little Table", price: 45.00})
        checkout.scan({code: "003", name: "Funky Light", price: 19.95})
        expect(checkout.total).to eq 74.20
    end 

    it "creates a total for multiple of the same item" do
        checkout.scan({code: "001", name: "Very Cheap Chair", price: 9.25})
        checkout.scan({code: "001", name: "Very Cheap Chair", price: 9.25})
        checkout.scan({code: "001", name: "Very Cheap Chair", price: 9.25})
        expect(checkout.total).to eq 27.75
    end 
end 