require 'promotions/total_promotion'

describe TotalPromotion do
    let(:total_promotion) { described_class.new( threshold_price: 60.0, percentage: 10 )}

    it "calculates discounts when applicable" do
        items = {
            "002" => { name: "Little Table", price: 45.00, quantity: 2 } 
        }

        expect(total_promotion.calculate_discount_for(items)).to eq 9
    end


    it "doesn't calculate when not necessary" do
        items = {
            "002" => { name: "Little Table", price: 45.00, quantity: 1 } 
        }

        expect(total_promotion.calculate_discount_for(items)).to eq 0
    end
end