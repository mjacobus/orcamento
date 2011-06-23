class RenamePessoasToUsuariosAndCreateFields < ActiveRecord::Migration
  def self.up
    rename_table(:pessoas,:usuarios)
    add_column(:usuarios,:senha_hash,:string,:limit => 255)
    add_column(:usuarios,:senha_salt,:string,:limit => 255)
    add_column(:usuarios,:ativo,:boolean,:default => false)
    add_column(:usuarios,:admin,:boolean,:default => false)
  end

  def self.down
    remove_column(:usuarios,:senha_hash)
    remove_column(:usuarios,:senha_salt)
    remove_column(:usuarios,:ativo)
    remove_column(:usuarios,:admin)
    rename_table(:usuarios,:pessoas)
  end
end
