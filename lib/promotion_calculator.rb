require 'promotions/bulk_promotion'
require 'promotions/total_promotion'

class PromotionCalculator
    def initialize(promotional_rules)
        @promotional_rules = promotional_rules
    end

    def new_total(items, total)
        chair_promo = BulkPromotion.new(item_code: '001', threshold_quantity: 2, promotional_price: 8.5)
        ten_percent_discount = TotalPromotion.new(threshold_price: 60.0, percentage: 10)

        if (@promotional_rules.include?(:ten_percent_discount))
            total - ten_percent_discount.calculate_discount_for(items)
        elsif (@promotional_rules.include?(:cheap_chair_discount))
            total - chair_promo.calculate_discount_for(items)
        else 
            total
        end
    end
end