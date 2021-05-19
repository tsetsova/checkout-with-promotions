require 'checkout'

describe Checkout do 

    context "no promotions" do 
        let(:checkout) { described_class.new() }

        it "creates a total for multiple items" do
            checkout.scan({code: "001", name: "Very Cheap Chair", price: 9.25})
            checkout.scan({code: "002", name: "Little Table", price: 45.00})
            checkout.scan({code: "003", name: "Funky Light", price: 19.95})
            expect(checkout.total).to eq 74.2
        end 

        it "creates a total for multiple of the same item" do
            checkout.scan({code: "001", name: "Very Cheap Chair", price: 9.25})
            checkout.scan({code: "001", name: "Very Cheap Chair", price: 9.25})
            checkout.scan({code: "001", name: "Very Cheap Chair", price: 9.25})
            expect(checkout.total).to eq 27.75
        end 
    end

    context "with 10% discount for total over 60" do 
        let(:checkout) { described_class.new([:ten_percent_discount]) }

        it "applies discount" do
            checkout.scan({code: "001", name: "Very Cheap Chair", price: 9.25})
            checkout.scan({code: "002", name: "Little Table", price: 45.00})
            checkout.scan({code: "003", name: "Funky Light", price: 19.95})
            expect(checkout.total).to eq 66.78
        end 

        it "doesn't apply discount if total is below 60" do
            checkout.scan({code: "001", name: "Very Cheap Chair", price: 9.25})
            checkout.scan({code: "002", name: "Little Table", price: 45.00})
            expect(checkout.total).to eq 54.25
        end 
    end

    context "with 2 or more chairs" do 
        let(:checkout) { described_class.new([:cheap_chair_discount]) }

        it "applies discount for 3 chairs" do
            checkout.scan({code: "001", name: "Very Cheap Chair", price: 9.25})
            checkout.scan({code: "001", name: "Very Cheap Chair", price: 9.25})
            checkout.scan({code: "001", name: "Very Cheap Chair", price: 9.25})
            expect(checkout.total).to eq 25.50
        end 

        it "applies discount for 2 chairs" do
            checkout.scan({code: "001", name: "Very Cheap Chair", price: 9.25})
            checkout.scan({code: "001", name: "Very Cheap Chair", price: 9.25})
            expect(checkout.total).to eq 17.00
        end 

        it "doesn't apply discount for 1 chair" do
            checkout.scan({code: "001", name: "Very Cheap Chair", price: 9.25})
            expect(checkout.total).to eq 9.25
        end 
    end
end 