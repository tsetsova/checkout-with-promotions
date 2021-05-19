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
        total = total_without_promotions

        return total if (@promotional_rules.empty?)   

        if (@promotional_rules.include?(:ten_percent_discount) && total > 60.0)
            total * 0.9
        elsif (@promotional_rules.include?(:cheap_chair_discount) && @items["001"][:quantity] >= 2)
            total - @items["001"][:quantity] * 0.75
        else 
            total
        end
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