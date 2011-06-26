class SessionController < ApplicationController
  def login
    @usuario = Usuario.new
  end
  
  def process_login
    
    usuario = Usuario.authenticate(params[:email],params[:senha])
    if usuario
     session[:usuario_id] = usuario.id
     redirect_to root_url, :notice => "Logado!"  
    else
      flash.now.alert = "Usuário ou senha invalidos"  
      render :login
    end
    
  end

  def logout
    session[:usuario_id] = nil
    redirect_to root_url  
  end

end
