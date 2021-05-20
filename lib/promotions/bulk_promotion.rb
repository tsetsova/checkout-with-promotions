class BulkPromotion
    def initialize(item_code:, threshold_quantity:, promotional_price: )
        @item_code  = item_code
        @threshold_quantity = threshold_quantity
        @promotional_price = promotional_price
    end
    
    def calculate_discount_for(items, _)
        item = items[@item_code]

        if (item && item[:quantity] >= @threshold_quantity)
            item[:quantity] * (item[:price] - @promotional_price)
        else 
            0
        end
    end
end