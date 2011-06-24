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

    ul = "<ul>"

    if current_user
      menu = %w(usuarios movimentos)
      
      menu.each do |item|
        ul << "<li>" + link_to(item, :controller => item) + "</li>"
      end
      
      menu = %w(pagos pendentes)
      menu.each do |item|
        ul << "<li>" + link_to(item, :controller => :movimentos, :action => item) + "</li>"
      end
      
      ul << "<li>" + link_to(:logout, :controller => :session, :action => :logout) + "</li>"
      
    else
        ul << "<li>" + link_to(:login, :controller => :session, :action => :login) + "</li>"
    end
    
    ul << "</ul>"
    
    raw ul if params[:controller] != "session"
  end

end
