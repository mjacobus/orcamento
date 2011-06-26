class Movimento < ActiveRecord::Base
  validates :tipo, :presence => {:message => 'Campo obrigatório'},
    :numericality => {:greater_than_or_equal_to => -1, :less_than_or_equal_to => 1,
      :message => "Valor inválido"}
  validates :valor, :presence => {:message => 'Campo obrigatório'}
  validates :descricao, :presence => {:message => 'Campo obrigatório'}
  
  def validate
    
  end
  
  
  belongs_to :usuario
end
