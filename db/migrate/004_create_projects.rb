class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.text :name
      t.text :description
      t.datetime :started_at
      t.integer :started_by_id
      t.datetime :completed_at
      t.integer :leaded_by_id
      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
