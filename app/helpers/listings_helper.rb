module ListingsHelper
  def compensation_in_dollars(percentage, list_price)
    amount = list_price * (percentage.to_f / 100 )
    number_with_precision(amount, precision: 2)
  end
end
