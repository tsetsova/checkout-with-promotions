require 'promotions/bulk_promotion'

describe BulkPromotion do
    let(:bulk_promotion) { described_class.new(item_code: "001", threshold_quantity: 2, promotional_price: 8.5) }

    it "calculates discounts when applicable" do
        items = {
            "001" => { name: "Very Cheap Chair", price: 9.25, quantity: 3},
            "002" => { name: "Little Table", price: 45.00, quantity: 1 } 
        }

        expect(bulk_promotion.calculate_discount_for(items, 72.75)).to eq 2.25
    end

    it "doesn't calculate when not necessary" do
        items = {
            "001" => { name: "Very Cheap Chair", price: 9.25, quantity: 1},
            "002" => { name: "Little Table", price: 45.00, quantity: 1 } 
        }

        expect(bulk_promotion.calculate_discount_for(items, 54.25)).to eq 0
    end
end
