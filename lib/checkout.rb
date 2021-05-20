class Checkout 
    def initialize(promotional_rules = [])
        @items = {}
        @promotional_rules = promotional_rules
    end

    def scan(item)
        code = item[:code]

        if (already_scanned?(item)) 
            @items[code][:quantity] += 1
        else 
            @items[code] = {name: item[:name], price: item[:price], quantity: 1}
        end
    end

    def total
        return total_without_promotions if (@promotional_rules.empty?)
 
        @promotional_rules.reduce(total_without_promotions) do |running_total, promo|
            running_total -= promo.calculate_discount_for(@items, running_total)
        end.round(2)
    end

    private
    
    def already_scanned?(item)
        @items.include?(item[:code])
    end 

    def total_without_promotions 
        @items.values.reduce(0) do |total, item| 
            total + item[:price] * item[:quantity]
        end
    end
end