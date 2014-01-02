class CreatePlugins < ActiveRecord::Migration
  def change
    create_table :plugins do |t|
      t.string :name
      t.integer :pid

      t.timestamps
    end
  end
end
