module ApplicationHelper
  
  def to_currency(number)
    number_to_currency(number, :unit => "R$ ", :separator => ",", :delimiter => ".")
  end
  
  def to_date(date)
    if (date != nil) 
      date.strftime("%d/%m/%Y")
    end
  end
  
  def menu
    menu = %w(pessoas movimentos)
    ul = "<ul>"
    menu.each do |item|
      ul << "<li>" + link_to(item, :controller => item) + "</li>"
    end
    
    menu = %w(pagos pendentes)
    menu.each do |item|
      ul << "<li>" + link_to(item, :controller => :movimentos, :action => item) + "</li>"
    end
    
    ul << "</ul>"
    raw ul
  end

end
