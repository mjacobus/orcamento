module ApplicationHelper

  def to_date(date)
    if (date != nil)
      date.strftime("%d/%m/%Y")
    end
  end

  def menu

    if current_user
      items = ActiveSupport::OrderedHash.new
      items["Home"] = {:controller => :index}
      items["Usuários"] = {:controller => :usuarios}
      items["Movimentos"] = {:controller => :movimentos}
      items["Pendentes"] = {:controller => :movimentos, :action => "pendentes"}
      items["Pagos"] = {:controller => :movimentos, :action => "pagos"}
      items["Logout"] = {:controller => "session", :action => "logout"}
    elsif
      items = {"Login" => {:controller => "session", :action => "login"}}
    end

    if items.length > 0 && params[:controller] != "session"
      ul = '<ul>'  
    
      items.each do |item, options|
        ul << '<li>' + link_to(item, options) + '</li>'  
      end
      
      ul << '</ul>'
      raw ul
    end
  end
  
  def get_classes
    "#{params[:controller]}_controller #{params[:action]}_action"
  end

end
