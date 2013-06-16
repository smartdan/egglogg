class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|
      t.string :name
      t.text :description
      t.datetime :deadline_at
      t.integer :account_id
      t.integer :project_id
      t.boolean :is_completed
      t.timestamps
    end
  end

  def self.down
    drop_table :tasks
  end
end
