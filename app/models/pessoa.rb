class Pessoa < ActiveRecord::Base
  validates :nome, :presence => {:message => "Campo obrigatório"},
    :uniqueness => {:case_sensitive => false, :message => "Já existe uma pessoa com este nome"}
end
