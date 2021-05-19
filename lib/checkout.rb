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

        total_without_promotions - @promotional_rules.map{|promo| promo.calculate_discount_for(@items)}.sum
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