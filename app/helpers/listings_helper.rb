module ListingsHelper
  def compensation_in_dollars(percentage, list_price)
    amount = list_price * (percentage.to_f / 100 )
    number_to_currency(amount, precision: 2)
  end
end
