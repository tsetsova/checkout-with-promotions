class TotalPromotion
  def initialize(threshold_price:, percentage:)
    @threshold_price = threshold_price
    @percentage = percentage
  end

  def calculate_discount_for(_, running_total)
    return 0 if running_total < 60.0

    running_total * @percentage / 100
  end
end
