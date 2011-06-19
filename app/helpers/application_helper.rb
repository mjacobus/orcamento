module ApplicationHelper
  
  def to_currency(number)
    number_to_currency(number, :unit => "R$ ", :separator => ",", :delimiter => ".")
  end
  
  def to_date(date)
    date.strftime("%d/%m/%Y")
  end

end
