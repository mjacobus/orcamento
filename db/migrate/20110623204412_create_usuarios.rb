class CreateUsuarios < ActiveRecord::Migration
  def self.up
    rename_table (:usuarios,:pessoas)
    create_table :usuarios do |t|
      t.string :nome
      t.string :email
      t.string :senha_hash
      t.string :senha_salt
      t.boolean :admin
      t.boolean :ativo

      t.timestamps
    end
  end

  def self.down
    drop_table :usuarios
    rename_table(:pessoas,:usuarios)
  end
end
