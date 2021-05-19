class TotalPromotion
    def initialize(threshold_price:, percentage: )
        @threshold_price  = threshold_price
        @percentage = percentage
    end

    def calculate_discount_for(items)
        total = total(items)

        return 0 if total < 60.0

        total * @percentage / 100
    end

    private

    def total(items)
        items.values.reduce(0) do |total, item| 
            total + item[:price] * item[:quantity]
        end
    end
end 