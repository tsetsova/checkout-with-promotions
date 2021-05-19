require 'checkout'
require 'promotions/bulk_promotion'
require 'promotions/total_promotion'

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
        let(:ten_percent_discount) { TotalPromotion.new(threshold_price: 60.0, percentage: 10) }
        let(:checkout) { described_class.new([ten_percent_discount]) }

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

    context "bulk discounts" do 
        let(:cheap_chair_discount) { BulkPromotion.new(item_code: '001', threshold_quantity: 2, promotional_price: 8.5) }
        let(:checkout) { described_class.new([cheap_chair_discount]) }

        it "applies discount for multiple chairs" do
            checkout.scan({code: "001", name: "Very Cheap Chair", price: 9.25})
            checkout.scan({code: "001", name: "Very Cheap Chair", price: 9.25})
            checkout.scan({code: "001", name: "Very Cheap Chair", price: 9.25})
            expect(checkout.total).to eq 25.50
        end 

        it "doesn't apply discount for 1 chair" do
            checkout.scan({code: "001", name: "Very Cheap Chair", price: 9.25})
            expect(checkout.total).to eq 9.25
        end 
    end
end 