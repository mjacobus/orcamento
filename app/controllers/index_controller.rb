class IndexController < ApplicationController
  def index
    @dates = []
    for i in -5..5 do
      @dates << Time.now.advance(:months => i)
    end

    @usuarios = Usuario.order('nome').all
  end
end
