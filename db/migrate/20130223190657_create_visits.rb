class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.string :url
      t.float :duration
      t.integer :site_id

      t.timestamps
    end
  end
end
