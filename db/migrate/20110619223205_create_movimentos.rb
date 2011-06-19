class CreateMovimentos < ActiveRecord::Migration
  def self.up
    create_table :movimentos do |t|
      t.integer :tipo
      t.float :valor
      t.float :valor_corrigido
      t.date :pagar_em
      t.date :data_pagamento
      t.string :descricao

      t.timestamps
    end
  end

  def self.down
    drop_table :movimentos
  end
end
