require 'bulk_promotion'

class PromotionCalculator
    def initialize(promotional_rules)
        @promotional_rules = promotional_rules
    end

    def new_total(items, total)
        chair_promo = BulkPromotion.new(item_code: '001', threshold_quantity: 2, promotional_price: 8.5)

        if (@promotional_rules.include?(:ten_percent_discount) && total > 60.0)
            total * 0.9
        elsif (@promotional_rules.include?(:cheap_chair_discount))
            total - chair_promo.calculate_discount_for(items)
        else 
            total
        end
    end
end