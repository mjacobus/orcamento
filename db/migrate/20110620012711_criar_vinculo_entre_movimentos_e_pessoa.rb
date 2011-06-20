class CriarVinculoEntreMovimentosEPessoa < ActiveRecord::Migration
  def self.up
    add_column :movimentos, :pessoa_id, :integer
    
    id = Pessoa.first.id
    Movimento.all.each do |m|
      m.pessoa_id = id
      m.save
    end
    
  end

  def self.down
    remove_column :movimentos, :pessoa_id
  end
end
