class Checkout 

    def initialize()
        @items = {}
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
        @items.values.reduce(0) do |total, item| 
            total + item[:price] * item[:quantity]
        end
    end

    private
    
    def already_scanned?(item)
        @items.include?(item[:code])
    end 
end 