class PromotionCalculator
    def initialize(promotional_rules)
        @promotional_rules = promotional_rules
    end

    def new_total(items, total)
        if (@promotional_rules.include?(:ten_percent_discount) && total > 60.0)
            total * 0.9
        elsif (@promotional_rules.include?(:cheap_chair_discount) && items["001"][:quantity] >= 2)
            total - items["001"][:quantity] * 0.75
        else 
            total
        end
    end
end