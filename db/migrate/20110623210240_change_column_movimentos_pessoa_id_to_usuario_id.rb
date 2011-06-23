class ChangeColumnMovimentosPessoaIdToUsuarioId < ActiveRecord::Migration
  def self.up
    rename_column(:movimentos,:pessoa_id,:usuario_id)
  end

  def self.down
    rename_column(:movimentos,:usuario_id,:pessoa_id)
  end
end
