class Checkout 

    def initialize()
        @items = []
    end

    def scan(item)
        @items.push(item)
    end

    def total
        @items.map{ |i| i[:price] }.sum
    end
end 