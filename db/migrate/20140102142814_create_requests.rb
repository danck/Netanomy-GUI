class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string :plugin
      t.string :domain

      t.timestamps
    end
  end
end
