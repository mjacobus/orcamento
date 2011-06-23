class DropTablePessoas < ActiveRecord::Migration
  def self.up
    drop_table(:pessoas)
  end

  def self.down
      create_table :pessoas do |t|
      t.string :nome

      t.timestamps
    end
  end
end
