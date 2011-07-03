class Movimento < ActiveRecord::Base
  validates :usuario_id, :presence => true
  validates :tipo, :presence => true,
    :numericality => {:greater_than_or_equal_to => -1, :less_than_or_equal_to => 1}
  validates :valor, :numericality =>true
  validates :descricao, :presence => true
  

  belongs_to :usuario
end
