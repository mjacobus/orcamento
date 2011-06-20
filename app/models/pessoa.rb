class Pessoa < ActiveRecord::Base
  validates :nome, :presence => {:message => "Campo obrigatório"},
    :uniqueness => {:case_sensitive => false, :message => "Já existe uma pessoa com este nome"}
    
  has_many :movimentos
end
