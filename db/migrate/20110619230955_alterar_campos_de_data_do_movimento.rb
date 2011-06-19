class AlterarCamposDeDataDoMovimento < ActiveRecord::Migration
  def self.up
    rename_column(:movimentos,:pagar_em,:data_prevista)
    rename_column(:movimentos,:data_pagamento,:data_realizacao)
  end

  def self.down
    rename_column(:movimentos,:data_prevista,:pagar_em)
    rename_column(:movimentos,:data_realizacao,:data_pagamento)
  end
end
