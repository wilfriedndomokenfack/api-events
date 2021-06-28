class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :title, null: false
      t.text :description
      t.date :start_date
      t.date :end_date
      t.time :start_time
      t.time :end_time

      t.references :user
      t.timestamps
    end
  end
end
